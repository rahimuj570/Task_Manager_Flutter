import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/controllers/auth_controller.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/screens/main_nav_bar_holder.dart';
import 'package:todo_app/ui/utils/assets_path_util.dart';
import 'package:todo_app/ui/widgets/app_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const name = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthController authController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController = context.read<AuthController>();
    _gotoNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        children: [
          Center(child: SvgPicture.asset(AssetsPathUtil.logoSvg, height: 100)),
          Align(
            alignment: Alignment(0, .8),
            child: CircularProgressIndicator(strokeWidth: 5),
          ),
          Align(
            alignment: Alignment(0, .98),
            child: Text(
              'Task_Manager by Rahimuj570 - v1.0',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _gotoNext() async {
    await Future.delayed(Duration(seconds: 3));

    if (await authController.checkLoggedin()) {
      await authController.getUserData();
      Navigator.pushReplacementNamed(context, MainNavBarHolder.name);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    }
  }
}
