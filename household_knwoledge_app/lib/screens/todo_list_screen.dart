import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/widgets/todo_creator_button.dart';
import 'package:intl/intl.dart';
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
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('House ToDos'),
      ),
      drawer: const MenuDrawer(),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          Task task = toDoList[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text('Due: ${DateFormat('dd-MM-yyyy HH:mm').format(task.deadline)}',
                                style:  TextStyle(
                                  fontSize: 14,
                                  color: task.deadline.difference(DateTime.now()).inHours < 24
                                    ? Colors.red // Red if due in less than 24 hours
                                    : Colors.black54, // Default color),
                                                  ),
                              ),
              trailing: task.isAccepted
                  ? Text('Accepted by ${task.assignedTo}', style :TextStyle(color: Colors.green) )
                  :  Text('Assigned to ${task.assignedTo == ''? "Unassigned" : task.assignedTo}', style: task.assignedTo == ''?  TextStyle(color: Colors.red): null),
            ),
          );
        },
 
      ),
      floatingActionButton:  ToDoCreator(),
    );
  }
}