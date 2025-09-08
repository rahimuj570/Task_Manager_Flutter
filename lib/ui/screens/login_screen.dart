import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/forgot_password_email_screen.dart';
import 'package:todo_app/ui/screens/main_nav_bar_holder.dart';
import 'package:todo_app/ui/screens/registration_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    "Get Start With",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 10),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(label: Text("Email")),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(label: Text("Password")),
                        ),
                        SizedBox(height: 12),
                        FilledButton(
                          onPressed: _loginCheck,
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _gotoForgotPasswordEmailScreen,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _gotoRegistrationScreen,
                                text: 'Sign Up',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _gotoRegistrationScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );
  }

  void _gotoForgotPasswordEmailScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordEmailScreen()),
    );
  }

  void _loginCheck() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainNavBarHolder()),
      (route) => false,
    );
  }
}
