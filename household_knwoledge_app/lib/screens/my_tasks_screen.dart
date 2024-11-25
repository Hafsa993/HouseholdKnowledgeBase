import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
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

    // Separate tasks into pending and completed
    List<Task> pendingTasks = taskProvider.myTasks(currentUser.username);
    List<Task> completedTasks = taskProvider.myCompletedTasks(currentUser.username);

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 6, 193, 240),
        title:  Text('My Tasks'),
      ),
      drawer:  MenuDrawer(),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tasks To-Do Section
             Text(
              "accepted Tasks:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
             SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: pendingTasks.length,
                itemBuilder: (context, index) {
                  Task task = pendingTasks[index];
                  return Card(
                    margin:  EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                               SizedBox(height: 4),
                              Text(
                                'Due: ${DateFormat('dd-MM-yyyy HH:mm').format(task.deadline)}',
                                style:  TextStyle(
                                  fontSize: 14,
                                  color: task.deadline.difference(DateTime.now()).inHours < 24
                                    ? Colors.red // Red if due in less than 24 hours
                                    : Colors.black54, // Default color
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
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey, // Initial button color
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // Mark task as completed and show reward popup
                              taskProvider.completeTask(task);
                              currentUser.addPoints(task.rewardPoints);
                              // Show popup for completed Task
                              showCompletionDialog(context, task);

                            },
                            icon:  Icon(Icons.check),
                            label:  Text("Completed"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
             SizedBox(height: 16),

            // Completed Tasks Section
             Text(
              "Completed Tasks:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
             SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  Task task = completedTasks[index];
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          task.title,
                          style:  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey, // Completed tasks in grey
                          ),
                        ),
                        Text(
                          '+ ${task.rewardPoints}',
                          style:  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
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
void showCompletionDialog(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor:  Color(0xFFECE4F8), // Light lavender background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with bounce animation
             Text(
              "Task Completed!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50), // Green text
              ),
            ).animate()
                .scale(begin: Offset(0.8, 0.8), end: Offset(1.0, 1.0), duration: 500.ms)
                .then(delay: 200.ms)
                .scale(begin: Offset(1.0, 1.0), end: Offset(1.05, 1.05), duration: 300.ms, curve: Curves.easeOut)
                .then()
                .scale(begin: Offset(1.05, 1.05), end: Offset(1.0, 1.0), duration: 200.ms, curve: Curves.easeIn),

            

             SizedBox(height: 16),

            // Animated smiley
             Icon(
              Icons.emoji_emotions,
              size: 90,
              color: Color.fromARGB(255, 178, 237, 38), // Purple smiley
            )
                .animate()
                .scale(begin: Offset(0, 0), end: Offset(1.0, 1.0), duration: 600.ms, curve: Curves.elasticOut),

             SizedBox(height:5 ),

            // Animated arrows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Column(
                  children: [
                    Icon(Icons.arrow_upward, color: Color(0xFF66BB6A), size: 30),
                  ],
                ),
                 SizedBox(width: 20),
              Column(
                  children: [  SizedBox(height: 8),
                    Icon(Icons.arrow_upward, color: Color(0xFF66BB6A), size: 30),
                  ],
                ), // Medium green arrows
                 SizedBox(width: 20),
              Column(
                  children: [
                    Icon(Icons.arrow_upward, color: Color(0xFF66BB6A), size: 30),
                  ],
                ),
                 SizedBox(width: 20),
              Column(
                  children: [  SizedBox(height: 8),
                    Icon(Icons.arrow_upward, color: Color(0xFF66BB6A), size: 30),
                  ],
                ),
              ]
                  .animate(interval: 150.ms) // Delay each arrow
                  .fadeIn(duration: 400.ms) // Fade-in effect
                  .slideY(begin: 0.2, end: 0.0, duration: 400.ms).then()
                  .slideY(begin: 0.0, end: 0.2, duration: 400.ms).then()
                  .slideY(begin: 0.2, end: 0.0, duration: 400.ms), // Slide up animation
            
            ),

             SizedBox(height: 20),

            // Animated reward points
            Text(
              "+ ${task.rewardPoints} 😊",
              style:  TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF388E3C), // Green text
              ),
            )
                .animate()
                .scale(begin: Offset(0, 0), end: Offset(1.0, 1.0), duration: 500.ms, curve: Curves.easeOut)
                .fadeIn(), // Fade-in for smooth entry

             SizedBox(height: 20),

            // "OK" button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color(0xFF4CAF50), // Vibrant green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child:  Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn(delay: 200.ms), // Button fade-in animation
          ],
        ),
      );
    },
  );
}