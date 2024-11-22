import 'package:flutter/material.dart';
import '../widgets/menu_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import '../providers/theme_provider.dart';

class OptionsScreen extends StatelessWidget {
  // Mock permissions data
  final Map<String, bool> permissions = {
    'Add Tasks': true,
    'Delete Tasks': false,
    'Modify Tasks': true,
    // Add more permissions as needed
  };

  // Notification
  final ValueNotifier<bool> notificationsEnabled = ValueNotifier(true);

  // Theme
  final ValueNotifier<bool> DarkThemeOn = ValueNotifier(false);

  // selected Language
  final ValueNotifier<String> selectedLanguage = ValueNotifier('English');

  // Available languages
  final List<String> languages = ['English', 'Italian', 'German', 'French'];

  Future<void> requestPermission(BuildContext context, Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${permission.toString()} granted')),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${permission.toString()} denied')),
      );
    }
  }
  
  OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 6, 193, 240),
        title: const Text('Options'),
      ),
      drawer: const MenuDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        // children: permissions.keys.map((perm) {
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: notificationsEnabled,
            builder: (context, value, child) {
              return SwitchListTile(
                // title: Text(perm),
                title: const Text('Enable Notifications'),
                // value: permissions[perm]!,
                value: value,
                onChanged: (newValue) {
                  // Handle permission change
                  notificationsEnabled.value = newValue;
                },
              );
            },
          ),
          const Divider(),
    
          // List of Permissions
          ListTile(
            title: const Text('Camera Permission')
            trailing: ElevatedButton(
              onPressed: () => requestPermission(context, Permission.camera),
              child: const Text('Request'),
            ),
          ),
    
          ListTile(
            title: const Text('Gallery Permission')
            trailing: ElevatedButton(
              onPressed: () => requestPermission(context, Permission.photos),
              child: const Text('Request'),
            ),
          ),
    
          ListTile(
            title: const Text('Geolocation Permission')
            trailing: ElevatedButton(
              onPressed: () => requestPermission(context, Permission.location),
              child: const Text('Request'),
            ),
          ),
    
          ListTile(
            title: const Text('Contacts Permission')
            trailing: ElevatedButton(
              onPressed: () => requestPermission(context, Permission.contacts),
              child: const Text('Request'),
            ),
          ),
          const Divider(),
    
          // List of Languages
          ValueListenableBuilder<String>(
            valueListenable: selectedLanguage,
            builder: (context, value, child) {
              return ListTile(
                title: const Text('Language'),
                trailing: DropdownButton<String>(
                  value: value,
                  onChanged: (String? newValue) {
                    selectedLanguage.value = newValue!;
                  },
                  items: languages.map<DropdownMenuItem<String>>((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language)
                    );
                  }).toList(),
                ),
              );
            },
          ),
          const Divider(),
    
          // Dark mode
          ValueListenableBuilder<bool>(
            valueListenable: DarkThemeOn,
            builder: (context, value, child) {
              return SwitchListTile(
                title: const Text('Dark Theme'),
                value: value,
                onChanged: (newValue) {
                  DarkThemeOn.value = newValue;
                },
              );
            },
          ),
          const Divider(),
    
          ...permissions.entries.map((entry) {
            return SwitchListTile(
              title: Text(entry.key),
              value: entry.value,
              onChanged: (value) {
                // not updating the state for semplicity
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
