import 'package:flutter/material.dart';
import '../widgets/menu_drawer.dart';

class OptionsScreen extends StatelessWidget {
  // Mock permissions data
  final Map<String, bool> permissions = {
    'Add Tasks': true,
    'Delete Tasks': false,
    'Modify Tasks': true,
    // Add more permissions as needed
  };

  OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('Options'),
      ),
      drawer: const MenuDrawer(),
      body: ListView(
        children: permissions.keys.map((perm) {
          return SwitchListTile(
            title: Text(perm),
            value: permissions[perm]!,
            onChanged: (value) {
              // Handle permission change
              // For simplicity, we're not actually updating the value
            },
          );
        }).toList(),
      ),
    );
  }
}
