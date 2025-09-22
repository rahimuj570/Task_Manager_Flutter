import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/data/utils/email_validator.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const name = "register";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Contrllers
  TextEditingController emailTEC = TextEditingController();
  TextEditingController firstNameTEC = TextEditingController();
  TextEditingController lastNameTEC = TextEditingController();
  TextEditingController mobileTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

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
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(label: Text("Email")),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Input Email";
                            } else if (!EmailValidator.emailValidator(
                              value.trim(),
                            )) {
                              return "Invalid Email!";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),

                        SizedBox(height: 8),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            label: Text("First Name"),
                          ),
                          validator: (value) => _nullInputValidator(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),

                        SizedBox(height: 8),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(label: Text("Last Name")),
                          validator: (value) => _nullInputValidator(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),

                        SizedBox(height: 8),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(label: Text("Mobile")),
                          validator: (value) => _nullInputValidator(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(label: Text("Password")),
                          validator: (value) => _nullInputValidator(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
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

  @override
  void dispose() {
    // TODO: implement dispose
    emailTEC.dispose();
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    mobileTEC.dispose();
    passwordTEC.dispose();
    super.dispose();
  }

  void _gotoLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginScreen.name);
  }

  String? _nullInputValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Input should be filled";
    }
    return null;
  }
}
