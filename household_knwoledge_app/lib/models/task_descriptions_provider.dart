import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';

class TaskDescriptorProvider with ChangeNotifier{

  List<TaskDescriptor> descriptors = [
    
    TaskDescriptor(
      title: 'AC Unit control', 
      instructions: 'Instructions on AC...', 
      category: 'Maintenance',  
      icon: Icons.ac_unit),
    
    TaskDescriptor(
      title: 'Sarahs birthday wish', 
      instructions: 'Sarahs gift...', 
      category: 'Care',  
      icon: Icons.child_friendly),

    TaskDescriptor(
      title: 'Basic shopping list', 
      instructions: 'Shopping list...', 
      category: 'Shopping',  
      icon: Icons.child_friendly),

    TaskDescriptor(
      title: 'Window cleaning', 
      instructions: 'Instructions on window cleaning...', 
      category: 'Cleaning',  
      icon: Icons.cottage),
    
    TaskDescriptor(
      title: 'Looping', 
      instructions: 'Instructions on window looping...', 
      category: 'Other',  
      icon: Icons.kebab_dining),

    TaskDescriptor(
      title: 'Piano practice', 
      instructions: 'Instructions on window looping...', 
      category: 'Care',  
      icon: Icons.headphones),

    TaskDescriptor(
      title: 'Names of relatives', 
      instructions: 'Names of relatives...', 
      category: 'Other',  
      icon: Icons.groups_2),

    TaskDescriptor(
      title: 'Writing an essay', 
      instructions: 'Instructions on writing on essay...', 
      category: 'Other',  
      icon: Icons.keyboard),
    
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
      category: 'Gardening', 
      icon: Icons.yard),
      
    TaskDescriptor(
      title: 'Mopping the floors', 
      instructions: 'Instructions on mopping...', 
      category: 'Cleaning', 
      icon: Icons.cleaning_services_outlined),
  ];

  void addTaskDescriptor (TaskDescriptor descriptor) async {
    descriptors.add(descriptor);
   // print('added a task with name: ${descriptor.title}');
   // print(descriptors.toString());
    notifyListeners();
  }
  // is this the same object?
  void removeTaskDescriptor(TaskDescriptor descriptor) {
    descriptors.remove(descriptor);
    notifyListeners();
  }

  void editTaskDescriptor(TaskDescriptor descriptor, String ntitle, String ninstructions, String ncategory, IconData nicon,) {
    //TaskDescriptor ntask = TaskDescriptor(title: ntitle, instructions: ninstructions, category: ncategory, icon: nicon);
    descriptor.title = ntitle;
    descriptor.instructions = ninstructions;
    descriptor.category = ncategory;
    descriptor.icon = nicon;
    notifyListeners();
  }

  int getLength() {
    return descriptors.length;
  }


} 