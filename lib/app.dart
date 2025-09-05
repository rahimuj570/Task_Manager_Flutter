import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Manager', home: SplashScreen());
  }
}
