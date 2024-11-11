import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/menu_drawer.dart';

class ProfileScreen extends StatelessWidget {
  final User currentUser = User(username: 'JohnDoe', points: 100);

  ProfileScreen({super.key}); // Example user with points

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      drawer: const MenuDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentUser.username,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Text(
              'Total Points: ${currentUser.points}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
