import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const name = "register";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                    "Join With Us",
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
                          decoration: InputDecoration(
                            label: Text("First Name"),
                          ),
                        ),

                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(label: Text("Last Name")),
                        ),

                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(label: Text("Mobile")),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(label: Text("Password")),
                        ),
                        SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {},
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(text: "Already have an account? "),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _gotoLoginScreen,
                                text: 'Login',
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

  void _gotoLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
