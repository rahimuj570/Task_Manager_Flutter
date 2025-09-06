import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      home: SplashScreen(),
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          fillColor: Colors.white,
          filled: true,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            fixedSize: Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
