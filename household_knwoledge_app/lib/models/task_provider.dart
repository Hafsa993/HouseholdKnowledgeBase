import 'package:flutter/material.dart';
import 'task_model.dart';
//hi

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

  List<Task> get pendingTasks(String username) {
    // Return the most urgent, unaccepted Tasks assgned to me
    DateTime now = DateTime.now();
    unsortedList = toDoList.where((task) => !task.isAccepted && task.assignedTo == username).toList();
    sortedList = unsortedList.sort((a, b) => a.deadline.compareTo(b.deadline));
    return sortedList;
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
