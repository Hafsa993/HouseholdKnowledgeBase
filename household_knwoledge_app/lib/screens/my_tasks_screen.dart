import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('My Tasks'),
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
                    taskProvider.completeTask(task);
                    // Add reward points to the user
                    currentUser.addPoints(task.rewardPoints);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
