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
        backgroundColor: const Color.fromARGB(255, 226, 224, 224),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                Wrap(
                children: [
                  Icon(task.icon),
                  SizedBox(width: 10),
                  Text(task.title, style: TextStyle(fontSize: 20),),
                ],
                ),
                SizedBox(height: 15,),
                Row(
                children: [
                  Text('Category:', style: TextStyle(fontSize: 16),),
                  SizedBox(width: 15,),
                  Chip(
                    label: Text(task.category, style: TextStyle(fontSize: 16, color: categoryColor(task.category)),), 
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,)
                ],
                            ),
                            Divider(),
                            Text(task.instructions, style: TextStyle(fontSize: 18),)
                            ]),
              )))
            
          ],
        ),
      ),
    );
  }
}