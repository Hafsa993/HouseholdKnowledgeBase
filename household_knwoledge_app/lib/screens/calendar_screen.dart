import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:household_knwoledge_app/models/task_model.dart';
import 'package:provider/provider.dart';
import 'package:household_knwoledge_app/models/task_provider.dart';
import '../widgets/menu_drawer.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Task> tasks = taskProvider.toDoList.where((task) => !task.isCompleted).toList();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 6, 193, 240),
        title: const Text('Calendar'),
      ),
      drawer: const MenuDrawer(),
      body: CalendarCarousel(
        onDayPressed: (date, events) {
          List<Task> tasksForDate = tasks.where((task) => isSameDay(task.deadline, date)).toList();
          if (tasksForDate.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Tasks for ${dateOnly(date.toLocal())}'),
                  /* content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tasksForDate.map((task) => Text(task.title)).toList(), 
                  ), */
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 200.0,
                  ),
                  content: Container(
                    width: double.maxFinite,
                    child: 
                    ListView.builder(
                      itemCount: tasksForDate.length,
                      itemBuilder: (context, index) {
                        Task lvtask = tasksForDate[index];
                        return Card(
                          child: ListTile(
                            title: Text(lvtask.title),
                            subtitle: Text(dateOnly(lvtask.deadline.toLocal())),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          }
        },
        weekendTextStyle: const TextStyle(color: Colors.red),
        
        thisMonthDayBorderColor: Colors.grey,
        markedDatesMap: _getMarkedDates(tasks),
        firstDayOfWeek: 1,
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  EventList<Event> _getMarkedDates(List<Task> tasks) {
    EventList<Event> markedDateMap = EventList<Event>(events: {});
    for (var task in tasks) {
      DateTime date = DateTime(task.deadline.year, task.deadline.month, task.deadline.day);
      markedDateMap.add(
        date,
        Event(date: date, title: task.title),
      );
    }
    return markedDateMap;
  }
}

// converts a date of DateTime type to a String containing only the date
String dateOnly(DateTime date){
  //date = DateTime.parse(date);
  var formattedDate = "${date.day}-${date.month}-${date.year}";
  return formattedDate;
}