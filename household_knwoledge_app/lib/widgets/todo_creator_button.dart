
import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/widgets/todo_creation.dart';

class ToDoCreator extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 6, 193, 240),
      onPressed: () => showDialog(context: context, 
          builder: (BuildContext context) => Dialog(
            child: ToDoForm(),
          ),
      ),
      tooltip: 'Create Task',
      child: 
        const Icon(Icons.add),
    );
  }
}      