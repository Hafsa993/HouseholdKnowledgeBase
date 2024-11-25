import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/widgets/confirm_task_completion.dart';
import 'package:household_knwoledge_app/widgets/todo_creator_button.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../models/task_provider.dart';
import '../models/user_model.dart';
import '../widgets/menu_drawer.dart';

class MyTasksScreen extends StatelessWidget {
  final User currentUser = User(username: 'JohnDoe');

  MyTasksScreen({super.key}); // Example user

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Task> myTasks = taskProvider.myTasks(currentUser.username);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('My To-Dos'),
      ),
      drawer: const MenuDrawer(),
      body: ListView.builder(
        itemCount: myTasks.length,
        itemBuilder: (context, index) {
          Task task = myTasks[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text('Due: ${task.deadline.toLocal()}'),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  if (value == true) {
                    showDialog(context: context, 
                      builder: (BuildContext context) => Dialog(
                          child: ConfirmTaskCompleted(task, currentUser),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton:  ToDoCreator(),
    );
  }
}
