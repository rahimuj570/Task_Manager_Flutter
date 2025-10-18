import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/controllers/recovery_password_controller.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/show_toast.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});
  static const name = "set_new_password";
  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordTEC = TextEditingController();
  final TextEditingController _confrmNewPasswordTEC = TextEditingController();
  late RecoveryPasswordController recoveryPasswordController;
  late Map<dynamic, dynamic> emailPinArgs;

  @override
  Widget build(BuildContext context) {
    emailPinArgs = ModalRoute.of(context)!.settings.arguments as Map;
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
                    "Set Password",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Minimum length of password should be 8 characters with number combinations",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _newPasswordTEC,
                          decoration: InputDecoration(label: Text("Password")),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) => value!.length < 7
                              ? 'Password must contains atleast 7 characters'
                              : null,
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("Confirm Password"),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.length < 7) {
                              return 'Password must contains atleat 7 characters';
                            } else if (value != _newPasswordTEC.text) {
                              return 'Password not matched';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        Consumer<RecoveryPasswordController>(
                          builder: (context, value, child) => Visibility(
                            visible: !value.isPasswordReseting,
                            replacement: CircularProgressIndicator(
                              strokeWidth: 5,
                            ),
                            child: FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _changePassword();
                                }
                              },
                              child: Text('Confirm'),
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

  Future<void> _changePassword() async {
    Map<String, dynamic> body = {
      "email": emailPinArgs['email'],
      "OTP": emailPinArgs['pin'],
      "password": _newPasswordTEC.text.trim(),
    };
    bool success = await recoveryPasswordController.doresetPassword(body);
    if (success) {
      if (mounted) {
        showSnackBar(
          context,
          recoveryPasswordController.getResetPasswordSuccessMessage!,
          ToastType.success,
        );
      }
      Future.delayed(Duration(seconds: 2));
      _gotoLoginScreen();
    } else {
      if (mounted) {
        showSnackBar(
          context,
          recoveryPasswordController.getResetPasswordErrorMessage!,
          ToastType.error,
        );
      }
    }
  }
}
