import 'package:flutter/material.dart';
import '../widgets/menu_drawer.dart';

class TaskType {
  String name;
  String description;

  TaskType({required this.name, required this.description});
}

class TasksScreen extends StatelessWidget {
  final List<TaskType> taskTypes = [
    TaskType(name: 'Laundry', description: 'Instructions on how to do laundry...'),
    TaskType(name: 'Cooking', description: 'Instructions on basic cooking...'),
    TaskType(name: 'Gardening', description: 'Instructions on gardening...'),
    // Add more task types
  ];

  TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('Task Decriptions'),
      ),
      drawer: const MenuDrawer(),
      body: ListView.builder(
        itemCount: taskTypes.length,
        itemBuilder: (context, index) {
          TaskType taskType = taskTypes[index];
          return Card(
            child: ListTile(
              title: Text(taskType.name),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(taskType.name),
                      content: Text(taskType.description),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
