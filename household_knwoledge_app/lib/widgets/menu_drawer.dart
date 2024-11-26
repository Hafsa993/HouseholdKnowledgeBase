import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/ranking_screen.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                  child: const DrawerHeader(
                    decoration: BoxDecoration(color: Color.fromARGB(255, 211, 239, 247)),
                    child: Text('Menu', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 24)),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
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
                  title: const Text('Task descriptions'),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TasksScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                      CupertinoIcons.calendar,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  title: const Text('Calendar'),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CalendarScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                      CupertinoIcons.chart_bar_alt_fill,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  title: const Text('Ranking'),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  RankingScreen()));
                  },
                ),
      
                
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: 
            Align(
              alignment: Alignment.bottomLeft,
              child: ListView(
                shrinkWrap: true,
                children: [
              Divider(indent: 20, color: const Color.fromARGB(255, 83, 115, 140)),
                  ListTile(
                    leading: const Icon(
                        CupertinoIcons.person_crop_circle,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                    },
                  ),
                  // align needed?
                  ListTile(
                    leading: const Icon(
                        CupertinoIcons.gear_solid,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ),
                    title: const Text('Options'),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OptionsScreen()));
                    },
                  ),
                        ],),
            ))
          
        ],
      ),
    );
  }
}
