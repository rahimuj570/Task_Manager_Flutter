import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/add_new_task_screen.dart';
import 'package:todo_app/ui/screens/edit_profile_screen.dart';
import 'package:todo_app/ui/screens/forgot_password_email_screen.dart';
import 'package:todo_app/ui/screens/forgot_password_pin_screen.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/screens/main_nav_bar_holder.dart';
import 'package:todo_app/ui/screens/registration_screen.dart';
import 'package:todo_app/ui/screens/set_new_password_screen.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';
import 'package:todo_app/ui/screens/task_screens/cancelled_task_screen.dart';
import 'package:todo_app/ui/screens/task_screens/completed_task_screen.dart';
import 'package:todo_app/ui/screens/task_screens/new_task_screen.dart';
import 'package:todo_app/ui/screens/task_screens/progress_task_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.green,
          strokeWidth: 8,
        ),

        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          fillColor: Colors.white,
          filled: true,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
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
      routes: {
        SplashScreen.name: (_) => SplashScreen(),
        LoginScreen.name: (_) => LoginScreen(),
        ForgotPasswordEmailScreen.name: (_) => ForgotPasswordEmailScreen(),
        ForgotPasswordPinScreen.name: (_) => ForgotPasswordPinScreen(),
        RegistrationScreen.name: (_) => RegistrationScreen(),
        NewTaskScreen.name: (_) => NewTaskScreen(),
        CompletedTaskScreen.name: (_) => CompletedTaskScreen(),
        CancelledTaskScreen.name: (_) => CancelledTaskScreen(),
        ProgressTaskScreen.name: (_) => ProgressTaskScreen(),
        AddNewTaskScreen.name: (_) => AddNewTaskScreen(),
        SetNewPasswordScreen.name: (_) => SetNewPasswordScreen(),
        MainNavBarHolder.name: (_) => MainNavBarHolder(),
        EditProfileScreen.name: (_) => EditProfileScreen(),
      },
      initialRoute: SplashScreen.name,
    );
  }
}
