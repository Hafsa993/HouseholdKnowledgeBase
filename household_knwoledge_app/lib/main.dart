import 'package:flutter/material.dart';
import 'package:household_knwoledge_app/models/user_provider.dart';
import 'package:provider/provider.dart';
import 'models/task_provider.dart';
import 'models/task_descriptions_provider.dart';
import 'screens/home_screen.dart';
//hi
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskDescriptorProvider()),
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
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,

      ),
      home: HomeScreen(),
    );
  }
}
