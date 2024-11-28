import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';
import 'package:household_knwoledge_app/models/task_descriptions_provider.dart';
import 'package:household_knwoledge_app/screens/add_task_description_screen.dart';
import 'package:household_knwoledge_app/screens/task_description_screen.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('Instructions'),
      ),
      drawer: const MenuDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Filter by category: ', style: TextStyle(fontSize: 16)),
              SizedBox(width: 10),
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
                      descriptors = sortList(newValue);
                    });
                  },
              ),
            ],
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
                  builder: (context) => AddTaskDescriptionScreen(),
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
}
