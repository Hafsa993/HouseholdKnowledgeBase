import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../models/task_provider.dart';
import '../widgets/menu_drawer.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Task> toDoList = taskProvider.toDoList.where((task) => !task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      drawer: const MenuDrawer(),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          Task task = toDoList[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text('Due: ${task.deadline.toLocal()}'),
              trailing: task.isAccepted
                  ? Text('Accepted by ${task.acceptedBy}')
                  : const Text('Unassigned', style: TextStyle(color: Colors.red)),
            ),
          );
        },
      ),
    );
  }
}
