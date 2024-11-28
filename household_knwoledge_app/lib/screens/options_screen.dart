import 'package:flutter/material.dart';
import '../widgets/menu_drawer.dart';
//import 'package:permission_handler/permission_handler.dart';

// import 'package:provider/provider.dart';
// import '../providers/theme_provider.dart';

class OptionsScreen extends StatelessWidget {

  final ValueNotifier<bool> cameraPermissionEnabled = ValueNotifier(false);
  final ValueNotifier<bool> galleryPermissionEnabled = ValueNotifier(false);
  final ValueNotifier<bool> geolocationPermissionEnabled = ValueNotifier(false);
  final ValueNotifier<bool> contactsPermissionEnabled = ValueNotifier(false);

  // Notification
  final ValueNotifier<bool> notificationsEnabled = ValueNotifier(true);

  // Theme
  final ValueNotifier<bool> DarkThemeOn = ValueNotifier(false);

  // selected Language
  final ValueNotifier<String> selectedLanguage = ValueNotifier('English');

  // Available languages
  final List<String> languages = ['English', 'Italian', 'German', 'French'];

  OptionsScreen({super.key});

  void togglePermission(BuildContext context, ValueNotifier<bool> permissionState, String permissionName) {
    permissionState.value = !permissionState.value;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(permissionState.value
            ? '$permissionName Enabled'
            : '$permissionName Disabled'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(
       backgroundColor: const Color.fromARGB(255, 226, 224, 224),
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
    
          // Camera Permission
          ListTile(
            title: const Text('Camera Permission'),
            trailing: ValueListenableBuilder<bool>(
              valueListenable: cameraPermissionEnabled,
              builder: (context, isEnabled, child) {
                return ElevatedButton(
                  onPressed: () => togglePermission(context, cameraPermissionEnabled, "Camera Permission"),
                  child: Text(isEnabled ? 'Disable' : 'Enable'),
                );
              },
            ),
          ),

          // Gallery Permission
          ListTile(
            title: const Text('Gallery Permission'),
            trailing: ValueListenableBuilder<bool>(
              valueListenable: galleryPermissionEnabled,
              builder: (context, isEnabled, child) {
                return ElevatedButton(
                  onPressed: () => togglePermission(context, galleryPermissionEnabled, "Gallery Permission"),
                  child: Text(isEnabled ? 'Disable' : 'Enable'),
                );
              },
            ),
          ),

          // Geolocation Permission
          ListTile(
            title: const Text('Geolocation Permission'),
            trailing: ValueListenableBuilder<bool>(
              valueListenable: geolocationPermissionEnabled,
              builder: (context, isEnabled, child) {
                return ElevatedButton(
                  onPressed: () => togglePermission(context, geolocationPermissionEnabled, "Geolocation Permission"),
                  child: Text(isEnabled ? 'Disable' : 'Enable'),
                );
              },
            ),
          ),

          // Contacts Permission
          ListTile(
            title: const Text('Contacts Permission'),
            trailing: ValueListenableBuilder<bool>(
              valueListenable: contactsPermissionEnabled,
              builder: (context, isEnabled, child) {
                return ElevatedButton(
                  onPressed: () => togglePermission(context, contactsPermissionEnabled, "Contacts Permission"),
                  child: Text(isEnabled ? 'Disable' : 'Enable'),
                );
              },
            ),
          ),
    
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
        ],
      ),
    );
  }
}

