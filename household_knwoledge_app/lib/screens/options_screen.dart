import 'package:flutter/material.dart';
import '../widgets/menu_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:provider/provider.dart';
// import '../providers/theme_provider.dart';

class OptionsScreen extends StatelessWidget {

  final ValueNotifier<bool> cameraPermissionEnabled = ValueNotifier(false);
  final ValueNotifier<bool> galleryPermissionEnabled = ValueNotifier(false);
  final ValueNotifier<bool> geolocationPermissionEnabled = ValueNotifier(false);
  final ValueNotifier<bool> contactsPermissionEnabled = ValueNotifier(false);

  // Initialization
  final ValueNotifier<bool> notificationsEnabled = ValueNotifier(true);
  final ValueNotifier<bool> DarkThemeOn = ValueNotifier(false);
  final ValueNotifier<String> selectedLanguage = ValueNotifier('English');
  final List<String> languages = ['English', 'Italiano', 'Deutsch', 'Français'];

  OptionsScreen({super.key}) {
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cameraPermissionEnabled.value = prefs.getBool('cameraPermissionEnabled') ?? false;
    galleryPermissionEnabled.value = prefs.getBool('galleryPermissionEnabled') ?? false;
    geolocationPermissionEnabled.value = prefs.getBool('geolocationPermissionEnabled') ?? false;
    contactsPermissionEnabled.value = prefs.getBool('contactsPermissionEnabled') ?? false;
    notificationsEnabled.value = prefs.getBool('notificationsEnabled') ?? false;
    DarkThemeOn.value = prefs.getBool('DarkThemeOn') ?? false;
    selectedLanguage.value = prefs.getString('selectedLanguage') ?? 'English';
  }

  Future<void> _savePermissionState(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveStringPreference(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> togglePermission(BuildContext context, ValueNotifier<bool> permissionState, String permissionName, Permission permission, String prefsKey) async {
    if (!permissionState.value) {
      final status = await permission.request();
      if (status.isGranted) {
        permissionState.value = true;
        await _savePermissionState(prefsKey, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$permissionName Enabled')),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$permissionName Denied')),
        );
      }
    }
    else {
      permissionState.value = false;
      await _savePermissionState(prefsKey, false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$permissionName Disabled')),
      );
    }
  }

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
                onChanged: (newValue) async {
                  // Handle permission change
                  notificationsEnabled.value = newValue;
                  await _savePermissionState('notificationsEnabled', newValue);
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
                  onPressed: () => togglePermission(context, cameraPermissionEnabled, "Camera Permission", Permission.camera, 'cameraPermissionEnabled'),
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
                  onPressed: () => togglePermission(context, galleryPermissionEnabled, "Gallery Permission", Permission.photos, 'galleryPermissionEnabled'),
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
                  onPressed: () => togglePermission(context, geolocationPermissionEnabled, "Geolocation Permission", Permission.location, 'geolocationPermissionEnable'),
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
                  onPressed: () => togglePermission(context, contactsPermissionEnabled, "Contacts Permission", Permission.contacts, 'contactsPermissionEnabled'),
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
                  onChanged: (String? newValue) async {
                    if (newValue != null) {
                      selectedLanguage.value = newValue;
                      await _saveStringPreference('selectedLanguage', newValue);
                    }
                  },
                  items: languages.map<DropdownMenuItem<String>>((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
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
                onChanged: (newValue) async {
                  DarkThemeOn.value = newValue;
                  await _savePermissionState('DarkThemeOn', newValue);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

