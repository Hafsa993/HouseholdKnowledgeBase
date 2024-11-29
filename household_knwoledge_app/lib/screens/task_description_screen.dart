import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';
import 'package:household_knwoledge_app/models/task_descriptions_provider.dart';
import 'package:provider/provider.dart';
// This screen displays the description of an instruction, accessed through instructions tab

class TaskDescriptionScreen extends StatefulWidget{
  const TaskDescriptionScreen({super.key, required this.task});
  final TaskDescriptor task;

  @override
  State<TaskDescriptionScreen> createState() => _TaskDescriptionScreenState();
}

class _TaskDescriptionScreenState extends State<TaskDescriptionScreen> {
  bool? isDeleted = false;

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
                  Icon(widget.task.icon),
                  SizedBox(width: 10),
                  Text(widget.task.title, style: TextStyle(fontSize: 20),),
                ],
                ),
                SizedBox(height: 15,),
                Row(
                children: [
                  Text('Category:', style: TextStyle(fontSize: 16),),
                  SizedBox(width: 15,),
                  Chip(
                    label: Text(widget.task.category, style: TextStyle(fontSize: 16, color: categoryColor(widget.task.category)),), 
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,)
                ],
                            ),
                            Divider(),
                            Text(widget.task.instructions, style: TextStyle(fontSize: 18),)
                            ]),
              ))),
          ],
        ),
      ),
      bottomNavigationBar: 
            ElevatedButton.icon(
              label: Text('Delete Task', style: TextStyle(color: Colors.white),),
              icon: const Icon(Icons.delete, color: Colors.white, size: 20,),
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.red)),
              onPressed: () async {isDeleted = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Are you sure you want to delete this instruction?"),
                    content: const Text("This is a non-reversible action."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          //val = true;
                          Navigator.pop(context, true);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red),
                        child: const Text('Yes, really delete'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.grey),
                        child: const Text("No, don't delete"),
                      ),
                    ],
                  );
                },
              );
              if (isDeleted == true){
                Provider.of<TaskDescriptorProvider>(context, listen: false).removeTaskDescriptor(widget.task);
                Navigator.of(context).pop();
              }
              }, 
              ),
    );
  }

   _showDeleteDialog(BuildContext context, TaskDescriptor descriptor, TaskDescriptorProvider taskDescriptorProvider) {
    //bool val = false;
    
    //print(val);
    //return val;
  }
}

