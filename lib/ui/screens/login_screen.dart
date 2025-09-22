import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/email_validator.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/screens/forgot_password_email_screen.dart';
import 'package:todo_app/ui/screens/main_nav_bar_holder.dart';
import 'package:todo_app/ui/screens/registration_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/show_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const name = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailTEC = TextEditingController();
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
                    "Get Start With",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: emailTEC,
                          decoration: InputDecoration(label: Text("Email")),
                          validator: (value) =>
                              EmailValidator.emailValidator(value!.trim()) ==
                                  true
                              ? null
                              : "Invalid Email",
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: passwordTEC,
                          decoration: InputDecoration(label: Text("Password")),
                          validator: (value) =>
                              _nullInputValidator(value, isPassword: true),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 12),
                        Visibility(
                          visible: !isProcessing,
                          replacement: CircularProgressIndicator(
                            strokeWidth: 5,
                          ),
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _loginCheck();
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
    Navigator.pushReplacementNamed(context, RegistrationScreen.name);
  }

  void _gotoForgotPasswordEmailScreen() {
    Navigator.pushReplacementNamed(context, ForgotPasswordEmailScreen.name);
  }

  Future<void> _loginCheck() async {
    setState(() {
      isProcessing = !isProcessing;
    });
    Map<String, dynamic> body = {
      "email": emailTEC.text.trim(),
      "password": passwordTEC.text.trim(),
    };
    ApiResponse apiResponse = await ApiCalller.postRequest(
      url: Urls.userLogin,
      body: body,
    );
    setState(() {
      isProcessing = !isProcessing;
    });
    if (apiResponse.statusCode == 200 &&
        apiResponse.responseData['status'] == 'success') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavBarHolder.name,
        (predicate) => false,
      );
    } else {
      showSnackBar(context, apiResponse.errorMessage!, ToastType.error);
    }
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
