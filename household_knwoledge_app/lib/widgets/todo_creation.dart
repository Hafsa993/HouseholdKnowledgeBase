import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:household_knwoledge_app/screens/ranking_screen.dart';

import '../models/task_model.dart';

class ToDoForm extends StatefulWidget {
  const ToDoForm({super.key});
  @override
  State<ToDoForm> createState() => _ToDoFormState();
}
class _ToDoFormState extends State<ToDoForm> {
  final todoLabelController = TextEditingController();
  final todoDueDateController = TextEditingController();
  final currentUser = "JohnDoe";
  var selectedUser = "JohnDoe";
  final allUsers = RankingScreen().currUsers;

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
          const Text('Create Task'),
          TextField( //set label
            controller: todoLabelController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Label'
            )
          ),
          TextField( //choose date
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
          Text("Assign user:"),
          DropdownButton( //assign user
            value: selectedUser,
            items: sortUsers(allUsers).map( (items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
            onChanged: (String? newValue) { 
                setState(() {
                  selectedUser = newValue!;
                });
              },
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
                    Task newtask = Task(title: todoLabelController.text, deadline: DateTime.parse(todoDueDateController.text), category: "", difficulty: 'extra hard', description: '', assignedTo: selectedUser, acceptedBy: selectedUser, isAccepted: true);
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
  picked ??= DateTime.now();
  setState(() {
    todoDueDateController.text = picked.toString().split(" ")[0];
  });
  }
}



