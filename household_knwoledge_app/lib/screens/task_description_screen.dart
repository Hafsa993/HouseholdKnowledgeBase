import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';
import 'package:household_knwoledge_app/models/task_descriptions_provider.dart';
import './change_task_descriptor_screen.dart';
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
  late TaskDescriptor temptask;
  @override
  void initState() {
    super.initState();
    temptask = widget.task;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 224, 224),
        /*
        actions: [
          //Edit Button
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue, size: 30,),
            color: Colors.blue,
            onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeTaskDescriptorScreen(task: widget.task),
                ),
              ).then((val) {
                if (val!= null){
                setState(() {
                  temptask = val;
                });
                }
              }
              )
            ;}
          ),
          IconButton(
            color: Colors.red,
            icon: const Icon(Icons.delete, color: Colors.red, size: 30,),
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
          )
        ],*/
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                alignment: WrapAlignment.start,
                children: [
                  Icon(widget.task.icon, color: categoryColor(widget.task.category),),
                  SizedBox(width: 10),
                  Text(widget.task.title, style: TextStyle(fontSize: 20),),
                ],
                ),
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Text('Category:', style: TextStyle(fontSize: 25),)),
                  SizedBox(width: 15,),
                  Flexible(
                    child: Chip(
                      label: Text(widget.task.category, style: TextStyle( color: categoryColor(widget.task.category)),), 
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                  )
                ],
                            ),
                            SizedBox(height:20,),
                            Divider(),
                            Container(decoration: BoxDecoration(border: Border.symmetric()),child: Text(widget.task.instructions, style: TextStyle(fontSize: 18),),)
                            ]),
              ))),
          ],
        ),
      ),
      
      bottomNavigationBar: 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.edit, color: Colors.white, size: 20,),
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue)),
                    label: Text('Edit instruction', style: TextStyle(color: Colors.white, fontSize: 16),),
                    onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeTaskDescriptorScreen(task: widget.task),
                        ),
                      ).then((val) {
                        if (val!= null){
                        setState(() {
                          temptask = val;
                        });
                        }
                      }
                      )
                    ;}
                  ),
                  ElevatedButton.icon(
                    label: Text('Delete instruction', style: TextStyle(color: Colors.white, fontSize: 16),),
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
                ],
              ),
            ),
    );
  }
}

