import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/menu_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User currentUser = User(
    username: 'JohnDoe', 
    points: 100,
    role: 'child',
    preferences: ['Cleaning', 'Cooking'],
    contributions: {'Cleaning': 50, 'Garden': 30, 'Cooking': 20},
  );

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    // Initialize the profile image with "f.jpeg"
    _image = XFile("assets/f.jpeg");
    _usernameController = TextEditingController(text: currentUser.username);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _updatePermissionStatus(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _checkAndOpenImageSource(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        _showPermissionDialog(
          context,
          'Camera',
          'cameraPermissionEnabled',
          Permission.camera,
          () => _pickImage(source),
        );
        return;
      }
    } 
    else if (source == ImageSource.gallery) {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        _showPermissionDialog(
          context,
          'Gallery',
          'galleryPermissionEnabled',
          Permission.photos,
          () => _pickImage(source),
        );
        return;
      }
    }
    _pickImage(source); // Permission already granted
  }

  void _showPermissionDialog(
    BuildContext context,
    String permissionName,
    String prefsKey,
    Permission permission,
    VoidCallback onPermissionGranted,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$permissionName Permission Required"),
          content: Text(
            "To proceed, you need to enable $permissionName permissions. Would you like to enable it now?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final status = await permission.request();
                if (status.isGranted) {
                  await _updatePermissionStatus(prefsKey, true);
                  onPermissionGranted();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$permissionName permission denied."),
                    ),
                  );
                }
              },
              child: const Text("Enable"),
            ),
          ],
        );
      },
    );
  }

  // Pick image from Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    }
    on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  void _saveUsername() {
    setState(() {
      currentUser.username = _usernameController.text;
      isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Username updated")),
    );
  }

  // Exit Button
  Future<void> _showExitConfirm(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to exit your account?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                // for semplicity we won't make the logout implementation for now
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        );
      },
    );
  }

// ProfileScreen({super.key});

  // Pie Chart
  List<PieChartSectionData> _generatePieChartData() {
    return currentUser.contributions.entries.map((entry) {
      final percentage = entry.value.toDouble();
      return PieChartSectionData(
        value: percentage,
        title: '${entry.key} (${percentage.toInt()}%)',
        color: _getTaskColor(entry.key),
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      );
    }).toList();
  }

  Color _getTaskColor(String task) {
    switch (task) {
      case 'Cleaning':
        return Colors.blue;
      case 'Garden':
        return Colors.green;
      case 'Cooking':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Show image picker dialog
  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pick an image for your Profile"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _checkAndOpenImageSource(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _checkAndOpenImageSource(ImageSource.gallery);
              },
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );
  }

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 193, 240),
        title: const Text('My Profile'),
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile picture
                GestureDetector(
                  onTap: () => _showImageDialog(context),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _image == null
                        ? const AssetImage('assets/f.png') as ImageProvider
                        : FileImage(File(_image!.path)),
                  ),
                ),
                const SizedBox(height: 16),

                // Editable Username
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isEditing)
                      Text(
                        currentUser.username,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: _usernameController,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          onSubmitted: (value) => _saveUsername(),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Enter username",
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(
                        isEditing ? Icons.check : Icons.edit,
                        color: isEditing ? Colors.green : Colors.blue,
                      ),
                      onPressed: () {
                        if (isEditing) {
                          _saveUsername();
                        }
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Role
                Text(
                  'Role: ${currentUser.role}',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // Points
                Text(
                  'Points: ${currentUser.points}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),

                // Preferences
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Preferred Tasks:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: currentUser.preferences
                          .map((task) => Chip(label: Text(task)))
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Pie Chart
                const Text(
                  'Task Contributions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: _generatePieChartData(),
                      centerSpaceRadius: 40,
                      sectionsSpace: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Exit account
                ElevatedButton(
                  onPressed: () => _showExitConfirm(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Exit Account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
