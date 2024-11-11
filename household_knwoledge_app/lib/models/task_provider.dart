import 'package:flutter/material.dart';
import 'task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> toDoList = [
    // Shared tasks among family members
    Task(
      title: 'Clean Kitchen',
      deadline: DateTime.now().add(const Duration(days: 1)),
      category: 'Cleaning',
      difficulty: 'Medium',
      description: 'Clean all surfaces, mop the floor, and take out the trash.',
      rewardPoints: 20,
    ),
    Task(
      title: 'Do Laundry',
      deadline: DateTime.now().add(const Duration(days: 2)),
      category: 'Household',
      difficulty: 'Easy',
      description: 'Wash, dry, and fold clothes.',
      rewardPoints: 15,
    ),
    // Add more tasks
  ];

  List<Task> get pendingTasks {
    // Return the most urgent tasks (e.g., tasks due in the next day)
    DateTime now = DateTime.now();
    return toDoList.where((task) => !task.isAccepted && task.deadline.difference(now).inDays <= 1).toList();
  }

  List<Task> myTasks(String username) {
    return toDoList.where((task) => task.acceptedBy == username && !task.isCompleted).toList();
  }

  void acceptTask(Task task, String username) {
    task.isAccepted = true;
    task.acceptedBy = username;
    notifyListeners();
  }

  void declineTask(Task task) {
    // For simplicity, we just leave the task as not accepted
    notifyListeners();
  }

  void completeTask(Task task) {
    task.isCompleted = true;
    notifyListeners();
  }

  void addTask(Task task) {
    toDoList.add(task);
    notifyListeners();
  }
}
