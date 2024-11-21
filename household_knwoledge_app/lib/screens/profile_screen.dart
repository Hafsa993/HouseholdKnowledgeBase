import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/menu_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatelessWidget {
  final User currentUser = User(username: 'JohnDoe', points: 100);
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  // Pick image from Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        _image = image;
      }
    }
    on PlatformException catch (e) {
      print("Error picking image: $e");
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
              child: const Text("Cancel"),
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

  ProfileScreen({super.key}); // Example user with points

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('My Profile'),
      ),
      drawer: const MenuDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Picture
            GestureDetector(
              onTap: () {
                _showImageDialog(context);
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image == null
                  ? const AssetImage('assets/default_avatar.png')
                  : FileImage(_image!.path) as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),            
            Text(
              currentUser.username,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Text(
              'Total Points: ${currentUser.points}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(heigh: 32),
            
            // Exit
            ElevatedButton(
              onPressed: () => _showExitConfirm(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text("Exit Account"),
            ),
          ],
        ),
      ),
    );
  }

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
}
