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
import 'package:household_knwoledge_app/models/user_provider.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    User currUser = userProvider.getCurrUser();

    return Drawer(
      //backgroundColor: Color.fromARGB(255, 211, 239, 247),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                SizedBox(
                  height: 220,
                  // This draws the header of the menu containing the profile 
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      //color: Colors.blue, 
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter, 
                        end: Alignment.topCenter, 
                        colors: [Theme.of(context).primaryColorLight, Theme.of(context).scaffoldBackgroundColor]
                        //colors: [Colors.black12, Colors.white],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top:10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                                },
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage("lib/assets/f.jpeg"),
                                ),
                              ),
                              SizedBox(height: 10,),

                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                                },
                                child: Text(currUser.username, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 24))
                              ),
                              Text('${currUser.points} points', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18)),
                            ],
                          ),
                        )
                      ],
                    ),
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
                  leading: const Icon(
                      Icons.maps_home_work_outlined,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  title: const Text('House ToDos'),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ToDoListScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                      Icons.checklist_rounded,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  title: const Text('My ToDos'),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyTasksScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                      CupertinoIcons.book_circle_fill,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  title: const Text('Instructions'),
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
                  title: const Text('Ranking List'),
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
                  SizedBox(height: 30,),
              Divider(indent: 20, endIndent: 20, color: const Color.fromARGB(255, 83, 115, 140)),
                  /* // profile as a menu tab 
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
                  ), */
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
                        
                    SizedBox(height: 20,)],),
            )),
          
        ],
      ),
    );
  }
}
