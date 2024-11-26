import 'dart:ui';

import 'package:flutter/material.dart';

class TaskDescriptor {
  String title;
  String instructions;
  String category;
  IconData icon;

  TaskDescriptor({
    required this.title,
    this.instructions = '',
    this.category = '',
    this.icon = Icons.favorite
  });
}

class TaskDescriptorProvider {

  List<TaskDescriptor> descriptors = [
    TaskDescriptor(title: 'Laundry', instructions: 'Instructions on how to do laundry...', category: 'Cleaning', icon: Icons.local_laundry_service),
    TaskDescriptor(title: 'Cooking', instructions: 'Instructions on basic cooking...', category: 'Cooking',  icon: Icons.countertops),
    TaskDescriptor(title: 'Gardening', instructions: 'Instructions on gardening...', category: 'Garden', icon: Icons.yard),
  ];


}    
Color categoryColor(String category){
  switch(category){
    case 'Cooking': return Colors.red;
    case 'Garden': return Colors.green;
  }
  //default Cleaning
  return Colors.blue;

}
final categories = <String>[
  "Cooking",
  "Cleaning",
  "Garden"
];
final selectableCategories = <String>[
  "Cooking",
  "Cleaning",
  "Garden",
  "All"
];