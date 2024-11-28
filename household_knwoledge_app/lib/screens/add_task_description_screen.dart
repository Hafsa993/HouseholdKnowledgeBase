import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';
import 'package:household_knwoledge_app/models/task_descriptions_provider.dart';
import 'package:provider/provider.dart';

class AddTaskDescriptionScreen extends StatefulWidget{
  const AddTaskDescriptionScreen({super.key});

  @override
  State<AddTaskDescriptionScreen> createState() => _AddTaskDescriptionScreenState();
}

class _AddTaskDescriptionScreenState extends State<AddTaskDescriptionScreen> {
  String _title = '';
  String? _category;
  String _instructions = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: Text('Add Instruction'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Title of the instruction',
            ),
            onChanged: (text) {
              _title = text;
            }
          ),

          DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                value: _category,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue;
                    // Reset assigned user if category changes
                   
                  });
                },
                validator: (value) => value == null ? 'Please select a category' : null,
              ),

          TextField(
            decoration: InputDecoration(
              hintText: 'Type instructions here',
            ),
            onChanged: (text) {
              _instructions = text;
            }
          ),

          ElevatedButton(onPressed: () {
            TaskDescriptor task = TaskDescriptor(title: _title, category: _category!, instructions: _instructions);
            Provider.of<TaskDescriptorProvider>(context, listen: false).addTaskDescriptor(task);
            print('${Provider.of<TaskDescriptorProvider>(context, listen: false).getLength()}');
          }, 
            child: Text('Add new instructions'),
          ),
        ],
      ),
    );
  }
}