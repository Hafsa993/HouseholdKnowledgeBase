import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';
// This screen displays the description of an instruction, accessed through instructions tab

class TaskDescriptionScreen extends StatelessWidget{
  const TaskDescriptionScreen({super.key, required this.task});
  final TaskDescriptor task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: categoryColor(task.category),
        title:  Row(
          children: [
            Icon(task.icon),
            SizedBox(width: 10),
            Text(task.title),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
        child: Column(
          children: [
            Text('Category: ${task.category}'),
            Text(task.instructions)
          ],
        ),
      ),
    );
  }
}