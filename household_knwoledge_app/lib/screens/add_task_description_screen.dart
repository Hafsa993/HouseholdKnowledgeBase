import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/task_descriptions_model.dart';
import 'package:household_knwoledge_app/models/task_descriptions_provider.dart';
import 'package:provider/provider.dart';

class AddTaskDescriptorScreen extends StatefulWidget {
  @override
  _AddTaskDescriptorScreenState createState() => _AddTaskDescriptorScreenState();
}

class _AddTaskDescriptorScreenState extends State<AddTaskDescriptorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _categoryController = TextEditingController();
  IconData? _selectedIcon;
  String? _category;

  void _saveTaskDescriptor() {
    if (_formKey.currentState!.validate() && _selectedIcon != null) {
      final newDescriptor = TaskDescriptor(
        title: _titleController.text,
        instructions: _instructionsController.text,
        category: _categoryController.text,
        icon: _selectedIcon!,
      );

      Provider.of<TaskDescriptorProvider>(context, listen: false)
          .addTaskDescriptor(newDescriptor);

      Navigator.of(context).pop(); // Navigate back after saving
    } else if (_selectedIcon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an icon for the task')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Instruction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _instructionsController,
                decoration: InputDecoration(labelText: 'Instructions'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter instructions';
                  }
                  return null;
                },
              ),/*
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ), */
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
              SizedBox(height: 16),
              Text(
                'Select Icon:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 10,
                children: [
                  _iconSelection(Icons.local_laundry_service),
                  _iconSelection(Icons.countertops),
                  _iconSelection(Icons.yard),
                  _iconSelection(Icons.cleaning_services_outlined),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveTaskDescriptor,
                child: Text('Save Task Descriptor'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconSelection(IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIcon = icon;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedIcon == icon ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 32),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _instructionsController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}

/* 
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
            TaskDescriptor task = TaskDescriptor(title: _title, category: _category!, instructions: _instructions, icon: Icons.abc_outlined);
            Provider.of<TaskDescriptorProvider>(context, listen: false).addTaskDescriptor(task);
            print('${Provider.of<TaskDescriptorProvider>(context, listen: false).getLength()}');
          }, 
            child: Text('Add new instructions'),
          ),
        ],
      ),
    );
  }
} */