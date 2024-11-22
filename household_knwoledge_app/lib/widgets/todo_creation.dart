import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_provider.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';

class ToDoForm extends StatefulWidget {
  const ToDoForm({super.key});
  @override
  State<ToDoForm> createState() => _ToDoFormState();
}
class _ToDoFormState extends State<ToDoForm> {
  final todoLabelController = TextEditingController();
  final todoDueDateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    todoLabelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Create To-Do'),
          TextField(
            controller: todoLabelController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Label'
            )
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Due by',
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
              )
            ),
            readOnly: true,
            onTap: (){
              _selectDate();
            },
            controller: todoDueDateController,
          ),
          const SizedBox(height: 15),
          Row( 
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                    Task newtask = Task(title: todoLabelController.text, deadline: DateTime.parse(todoDueDateController.text), category: "", difficulty: 'extra hard', description: '');
                    TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
                    taskProvider.addTask(newtask);
                    Navigator.pop(context);
                },
                child: const Text("Create"),
              ) 
            ],
          ),

        ],
      ),
    );
  }
  Future<void> _selectDate() async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now().add(Duration(days: 1)),
    firstDate: DateTime.now(), 
    lastDate: DateTime.now().add(Duration(days: 22))
  );
  if (picked != null){
    setState(() {
      todoDueDateController.text = picked.toString().split(" ")[0];
    });
  }
}
}



