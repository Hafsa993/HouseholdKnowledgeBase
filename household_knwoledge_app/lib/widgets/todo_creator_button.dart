
import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/widgets/todo_creation.dart';

class ToDoCreator extends StatelessWidget {
  const ToDoCreator({super.key});

  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 21, 208, 255),
      //backgroundColor: Theme.of(context).primaryColorLight,
      onPressed: () => showDialog(context: context, 
          builder: (BuildContext context) => Dialog(
            child: ToDoForm(),
          ),
      ),
      tooltip: 'Create Task',
      child: 
        const Icon(Icons.add, //color: Colors.white,
        ),
    );
  }
}      