import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/forgot_password_pin_screen.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});
  static const name = "forgot_email";

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
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
                    "Your Email Address",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "A 6 digit verification pin will sent to you email address",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(label: Text("Email")),
                        ),
                        SizedBox(height: 12),
                        FilledButton(
                          onPressed: _gotoPinScreen,
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
                              TextSpan(text: "Have an account? "),
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
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.name,
      (route) => false,
    );
  }

  void _gotoPinScreen() {
    Navigator.pushNamed(context, ForgotPasswordPinScreen.name);
  }
}
