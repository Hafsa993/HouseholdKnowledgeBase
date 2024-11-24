import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../models/task_provider.dart';
import '../models/user_model.dart';
import '../widgets/menu_drawer.dart';

class HomeScreen extends StatelessWidget {
  final User currentUser = User(username: 'JohnDoe'); // Example user

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Task> urgentTasks = taskProvider.pendingTasks(currentUser.username);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 193, 240),
        title: const Text('Home'),
      ),
      drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Top Users',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 16),
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
  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Task Title
        Text(
          task.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        // Task Details
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Due: ${DateFormat('dd-MM-yyyy HH:mm').format(task.deadline)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Difficulty: ${task.difficulty}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Reward: ${task.rewardPoints}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            // Buttons Section
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Increase padding
                        minimumSize: const Size(70, 40), // Ensure minimum button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _showAcceptDialog(context, task, taskProvider),
                      child: const Text('Accept'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        minimumSize: const Size(70, 40), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _showDeclineDialog(context, task, taskProvider),
                      child: const Text('Decline'),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  // Helper to show accept dialog
  void _showAcceptDialog(BuildContext context, Task task, TaskProvider taskProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to accept this task?"),
          content: const Text("This is a non-reversible action."),
          actions: [
            TextButton(
              onPressed: () {
                taskProvider.acceptTask(task, currentUser.username);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 6, 201, 64)),
              child: const Text('Yes, really accept'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              child: const Text("No, don't accept"),
            ),
          ],
        );
      },
    );
  }

  // Helper to show decline dialog
  void _showDeclineDialog(BuildContext context, Task task, TaskProvider taskProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to decline this task?"),
          content: const Text("This is a non-reversible action."),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showReasoningDialog(context, task, taskProvider);
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red),
                  child: const Text('Yes, really decline'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green),
                  child: const Text("No, don't decline"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Helper to show reasoning dialog
  void _showReasoningDialog(BuildContext context, Task task, TaskProvider taskProvider) {
    TextEditingController reasoningController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Provide Reasoning"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Please provide a reason for declining this task."),
              const SizedBox(height: 8),
              TextField(
                controller: reasoningController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your reason here",
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String reasoning = reasoningController.text;
                if (reasoning.isNotEmpty) {
                  taskProvider.declineTask(task);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Reasoning cannot be empty!"),
                      backgroundColor: Color.fromARGB(240, 255, 8, 4),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green),
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
