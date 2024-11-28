import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        //fontFamily: GoogleFonts.merriweather().toString(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 102, 163, 255),contrastLevel: 1),
        brightness: Brightness.light,
        useMaterial3: true, // Enable Material 3 for a modern design
        textTheme: TextTheme(
          titleLarge: GoogleFonts.merriweather(),
          bodyMedium: GoogleFonts.merriweather(),
          displayMedium: GoogleFonts.merriweather(),
          labelMedium: GoogleFonts.merriweather(),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
