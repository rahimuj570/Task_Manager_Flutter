import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/utils/email_validator.dart';
import 'package:todo_app/ui/controllers/recovery_password_controller.dart';
import 'package:todo_app/ui/screens/forgot_password_pin_screen.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/show_toast.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});
  static const name = "forgot_email";

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final GlobalKey<FormState> _formlKey = GlobalKey<FormState>();
  late RecoveryPasswordController recoveryPasswordController;
  @override
  Widget build(BuildContext context) {
    recoveryPasswordController = context.read<RecoveryPasswordController>();
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
                    key: _formlKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailTEC,
                          decoration: InputDecoration(label: Text("Email")),
                          validator: (value) =>
                              EmailValidator.emailValidator(value!.trim()) ==
                                  true
                              ? null
                              : "Invalid Email",
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 12),
                        Consumer<RecoveryPasswordController>(
                          builder: (context, value, child) => Visibility(
                            visible: !value.isEmailVerifying,
                            replacement: CircularProgressIndicator(
                              strokeWidth: 5,
                            ),
                            child: FilledButton(
                              onPressed: () {
                                if (_formlKey.currentState!.validate()) {
                                  _gotoPinScreen();
                                }
                              },
                              child: Icon(Icons.arrow_circle_right_outlined),
                            ),
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

  Future<void> _gotoPinScreen() async {
    bool success = await recoveryPasswordController.recoveryVerifyEmail(
      _emailTEC.text,
    );
    if (success) {
      if (!mounted) return;
      showSnackBar(
        context,
        recoveryPasswordController.getSentPinMessage!,
        ToastType.success,
      );
      await Future.delayed(Duration(seconds: 1));
      if (!mounted) return;
      Navigator.pushNamed(
        context,
        ForgotPasswordPinScreen.name,
        arguments: _emailTEC.text,
      );
    } else {
      if (!mounted) return;
      showSnackBar(context, "Email is not registered!", ToastType.error);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEC.dispose();
    super.dispose();
  }
}
