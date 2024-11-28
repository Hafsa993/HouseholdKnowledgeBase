import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';

class TaskDescriptorProvider with ChangeNotifier{

  List<TaskDescriptor> descriptors = [
    TaskDescriptor(title: 'Laundry', instructions: 'Instructions on how to do laundry...', category: 'Cleaning', icon: Icons.local_laundry_service),
    TaskDescriptor(title: 'Cooking', instructions: 'Instructions on basic cooking...', category: 'Cooking',  icon: Icons.countertops),
    TaskDescriptor(title: 'Gardening', instructions: 'Instructions on gardening...', category: 'Garden', icon: Icons.yard),
  ];

  void addTaskDescriptor (TaskDescriptor descriptor) {
    descriptors.add(descriptor);
    notifyListeners();
  }

  int getLength() {
    return descriptors.length;
  }


} 