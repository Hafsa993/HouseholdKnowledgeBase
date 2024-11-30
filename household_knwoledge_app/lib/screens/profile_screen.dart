import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';
import 'package:household_knwoledge_app/models/user_provider.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../widgets/menu_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  // Pick image from Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    User currUser = Provider.of<UserProvider>(context, listen: false).getCurrUser();
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
        _image = image;
        currUser.profilepath = image.path;
        });
      }
    }
    on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
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
                //Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        );
      },
    );
  }

// ProfileScreen({super.key});

  // Pie Chart
  List<PieChartSectionData> _generatePieChartData(BuildContext context) {
     final userProvider = Provider.of<UserProvider>(context);
    
    User currentUser = userProvider.getCurrUser();
     final sum = currentUser.contributions.values.fold<double>(0.0, 
     (sum, value) => sum + value.toDouble(),);
    return currentUser.contributions.entries.map((entry) {
      final percentage = (entry.value.toDouble() / sum) * 100.0;
      return PieChartSectionData(
        value: percentage,
        title: '${entry.key} (${percentage.toInt()}%)',
        color: categoryColor(entry.key),
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ),
      );
    }).toList();
  }

  Color _getTaskColor(String task) {
    switch (task) {
      case 'Cleaning':
        return Colors.blue;
      case 'Laundry':
        return Colors.green;
      case 'Cooking':
        return Colors.orange;
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
                _pickImage(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    User currentUser = userProvider.getCurrUser();
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 224, 224),
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
                  child: Stack(
                    children: [CircleAvatar(
                      radius: 60,
                      backgroundImage: Provider.of<UserProvider>(context, listen: false).getProfileOfCurrUser(),
                    ),
                    Positioned(bottom: -3, right: -3, child: Icon(Icons.edit, size: 30, color: Colors.grey[700],))
                  ],
                ),
                  
                ),
                const SizedBox(height: 8),
                
                // Username
                Text(
                  currentUser.username,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                //const SizedBox(height: 4),

                // Points
                Text(
                  'Points: ${currentUser.points}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 32, 129, 35)),
                ),
                const SizedBox(height: 4),

                
                // Role
                Text(
                  'Role: ${currentUser.role}',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // Preferences
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Preferred Tasks:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    //const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: currentUser.preferences
                          .map((task) => Chip(label: Text(task, style: TextStyle(color: categoryColor(task)),)))
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
                //const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      
                      sections: _generatePieChartData(context),
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
                  child: const Text("Exit Account", style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
