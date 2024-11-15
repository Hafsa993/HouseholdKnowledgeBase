import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_provider.dart';
import 'screens/home_screen.dart';
//hi
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        // You can add UserProvider here if needed
      ],
      child: const HouseholdApp(),
    ),
  );
}

class HouseholdApp extends StatelessWidget {
  const HouseholdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Household App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
