import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/todo_list_screen.dart';
import '../screens/my_tasks_screen.dart';
import '../screens/tasks_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/options_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 211, 239, 247),
      child: ListView(

        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 6, 193, 240)),
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
          ),
          ListTile(
            title: const Text('To-Do List'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ToDoListScreen()));
            },
          ),
          ListTile(
            title: const Text('My Tasks'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyTasksScreen()));
            },
          ),
          ListTile(
            title: const Text('Tasks'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TasksScreen()));
            },
          ),
          ListTile(
            title: const Text('Calendar'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CalendarScreen()));
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            },
          ),
          ListTile(
            title: const Text('Options'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OptionsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
