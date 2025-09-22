import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/email_validator.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/show_toast.dart';

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

  bool isProcessing = false;
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
                          controller: emailTEC,
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
                          controller: firstNameTEC,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            label: Text("First Name"),
                          ),
                          validator: (value) => _nullInputValidator(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),

                        SizedBox(height: 8),
                        TextFormField(
                          controller: lastNameTEC,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(label: Text("Last Name")),
                          validator: (value) => _nullInputValidator(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),

                        SizedBox(height: 8),
                        TextFormField(
                          controller: mobileTEC,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(label: Text("Mobile")),
                          validator: (value) => _nullInputValidator(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: passwordTEC,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(label: Text("Password")),
                          validator: (value) =>
                              _nullInputValidator(value, isPassword: true),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 12),
                        Visibility(
                          visible: !isProcessing,
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _registrationUser();
                              }
                            },
                            child: Icon(Icons.arrow_circle_right_outlined),
                          ),
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
          Visibility(
            visible: isProcessing,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
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

  Future<void> _registrationUser() async {
    Map<String, dynamic> body = {
      "email": emailTEC.text,
      "firstName": firstNameTEC.text,
      "lastName": lastNameTEC.text,
      "mobile": mobileTEC.text,
      "password": passwordTEC.text,
    };
    setState(() {
      isProcessing = !isProcessing;
    });
    ApiResponse apiResponse = await ApiCalller.postRequest(
      url: Urls.userRegistration,
      body: body,
    );
    setState(() {
      isProcessing = !isProcessing;
    });
    if (apiResponse.responseData['status'] == 'fail') {
      showSnackBar(context, apiResponse.responseData['data'], ToastType.error);
    } else {
      showSnackBar(
        context,
        "Registration completed successfully!",
        ToastType.success,
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    }
  }

  void _gotoLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginScreen.name);
  }

  String? _nullInputValidator(String? value, {bool? isPassword}) {
    if (value?.trim().isEmpty ?? true) {
      return "Input should be filled";
    } else if (isPassword != null) {
      if (value!.trim().length < 7) {
        return "Password length must be mor than 6";
      }
    }
    return null;
  }
}
