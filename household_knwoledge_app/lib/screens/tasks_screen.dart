import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';
import 'package:household_knwoledge_app/models/task_descriptions_provider.dart';
import 'package:household_knwoledge_app/models/task_provider.dart';
import 'package:household_knwoledge_app/screens/add_task_description_screen.dart';
import 'package:household_knwoledge_app/screens/task_description_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/menu_drawer.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({super.key});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  final taskDescriptorProvider = TaskDescriptorProvider();
  List<TaskDescriptor> descriptors = TaskDescriptorProvider().descriptors;
  String dropdownvalue = 'All';
  String searchQuery = '';


  @override
  Widget build(BuildContext context) {
    descriptors = context.watch<TaskDescriptorProvider>().descriptors;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('Instructions'),
      ),
      drawer: const MenuDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  filterTasks(searchQuery, dropdownvalue, descriptors);
                });
              },
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                 borderSide: BorderSide(color: const Color.fromARGB(255, 66, 67, 67), width: 2), // Color of the border when not focused
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0), // Rounded corners for focused state
        borderSide: BorderSide(color: const Color.fromARGB(255, 57, 58, 57), width: 2), // Color of the border when focused
      ),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          DropdownButton(
            value: dropdownvalue,
            items: selectableCategories.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
            onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalue = newValue!;
                  filterTasks(searchQuery, newValue, descriptors);
                });
              },
          ),
          Expanded(child:
            ListView.builder(
              shrinkWrap: true,
              itemCount: descriptors.length,
              itemBuilder: (context, index) {
                TaskDescriptor descriptor = descriptors[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.circle),
                    trailing: Icon(descriptor.icon),
                    iconColor:  categoryColor(descriptor.category),
                    title: Text(descriptor.title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDescriptionScreen(task: descriptor),
                        ),
                      );
                    },
                  ),
                );
              },
            ), 
          ),
          ElevatedButton(
            child: Text('Add Instruction'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskDescriptorScreen(),
                ),
              );
            },
          ),
        ]
      ),
    );
  }

  List<TaskDescriptor> sortList(String categ) {
    final returnval = TaskDescriptorProvider().descriptors.where((i) => i.category == categ).toList();
    return returnval.isEmpty ? TaskDescriptorProvider().descriptors : returnval;
  }

  // Function to filter tasks based on search query and selected category
  void filterTasks(String query, String category, List<TaskDescriptor> allTasks) {
    print(allTasks.toString() + ' filtered list');
    // Filter tasks by category
    List<TaskDescriptor> filteredByCategory = category == 'All'
        ? allTasks
        : allTasks.where((task) => task.category == category).toList();

    // Further filter tasks by search query
    descriptors = filteredByCategory.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase()) ||
             task.instructions.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
