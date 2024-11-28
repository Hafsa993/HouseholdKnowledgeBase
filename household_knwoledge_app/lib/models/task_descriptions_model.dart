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