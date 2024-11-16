import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../models/task_provider.dart';
import '../models/user_model.dart';
import '../widgets/menu_drawer.dart';

class HomeScreen extends StatelessWidget {
  final User currentUser = User(username: 'JohnDoe');// Example user

  HomeScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Task> urgentTasks = taskProvider.pendingTasks(currentUser.username);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('Home'),
      ),
      drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top 3 Users (For simplicity, mock data)
            const Text(
              'Top Users',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // You can implement the Podium widget similar to the previous example
            // For brevity, we'll skip it here

            const SizedBox(height: 16),
            // Pending Tasks
            const Text(
              'Your pending Tasks',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: urgentTasks.isEmpty
                  ? const Center(child: Text('No pending tasks!'))
                  : ListView.builder(
                      itemCount: urgentTasks.length,
                      itemBuilder: (context, index) {
                        Task task = urgentTasks[index];
                        return Card(
                          child: ListTile(
                            title: Text(task.title),
                            subtitle: Text('Due: ${task.deadline.toLocal()}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                  onPressed: () {
                                    taskProvider.acceptTask(task, currentUser.username);
                                  },
                                  child: const Text('Accept'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                  onPressed: () {
                                    taskProvider.declineTask(task);
                                  },
                                  child: const Text('Decline'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
