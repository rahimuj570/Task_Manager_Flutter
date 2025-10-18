import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/controllers/recovery_password_controller.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/screens/set_new_password_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/show_toast.dart';

class ForgotPasswordPinScreen extends StatefulWidget {
  const ForgotPasswordPinScreen({super.key});
  static const name = "forgot_password";

  @override
  State<ForgotPasswordPinScreen> createState() =>
      _ForgotPasswordPinScreenState();
}

class _ForgotPasswordPinScreenState extends State<ForgotPasswordPinScreen> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.green),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  bool _isPinCompleted = false;
  late String email;
  late RecoveryPasswordController recoveryPasswordController;
  final TextEditingController _pinTEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
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
                  IconButton(
                    onPressed: () {
                      debugPrint('object');
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  SizedBox(height: 70),
                  Text(
                    "Pin Verification",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "A 6 digit verification pin has been sent to your email address",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  Form(
                    child: Column(
                      children: [
                        Pinput(
                          controller: _pinTEC,
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          onChanged: (value) {
                            if (value.length != 6) {
                              setState(() {
                                _isPinCompleted = false;
                              });
                            }
                          },
                          onCompleted: (pin) {
                            setState(() {
                              _isPinCompleted = true;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        Consumer<RecoveryPasswordController>(
                          builder: (context, value, child) => Visibility(
                            visible: !value.isPinVerifying,
                            replacement: CircularProgressIndicator(
                              strokeWidth: 5,
                            ),
                            child: FilledButton(
                              onPressed: _isPinCompleted == false
                                  ? null
                                  : () => _verifyPin(_pinTEC.text.trim()),
                              child: Text('Verify'),
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

  Future<bool> _verifyPin(String pin) async {
    bool success = await recoveryPasswordController.doVerifyPin(email, pin);
    if (success) {
      if (mounted) {
        showSnackBar(
          context,
          recoveryPasswordController.getVerifyPinMessage!,
          ToastType.success,
        );
      }
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SetNewPasswordScreen.name,
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        showSnackBar(
          context,
          recoveryPasswordController.getVerifyPinMessageError!,
          ToastType.error,
        );
      }
    }
    return success;
  }
}
