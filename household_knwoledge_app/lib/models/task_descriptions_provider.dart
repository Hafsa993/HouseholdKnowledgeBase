import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';

class TaskDescriptorProvider with ChangeNotifier{

  List<TaskDescriptor> descriptors = [
    TaskDescriptor(
      title: 'Laundry', 
      instructions: 'Instructions on how to do laundry...', 
      category: 'Cleaning', 
      icon: Icons.local_laundry_service),

    TaskDescriptor(
      title: 'Cooking', 
      instructions: 'Instructions on basic cooking...', 
      category: 'Cooking',  
      icon: Icons.countertops),

    TaskDescriptor(
      title: 'Gardening', 
      instructions: 'Instructions on gardening...', 
      category: 'Garden', 
      icon: Icons.yard),
      
    TaskDescriptor(
      title: 'Mopping the floors', 
      instructions: 'Instructions on mopping...', 
      category: 'Cleaning', 
      icon: Icons.cleaning_services_outlined),
  ];

  void addTaskDescriptor (TaskDescriptor descriptor) async {
    descriptors.add(descriptor);
    print('added a task with name: ${descriptor.title}');
    print(descriptors.toString());
    notifyListeners();
  }

  int getLength() {
    return descriptors.length;
  }


} 