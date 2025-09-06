import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/ui/screens/login_screen.dart';
import 'package:todo_app/ui/utils/assets_path_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gotoNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AssetsPathUtil.backgroundSvg,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          Center(child: SvgPicture.asset(AssetsPathUtil.logoSvg, height: 35)),
          Align(
            alignment: Alignment(0, .8),
            child: CircularProgressIndicator(color: Colors.green),
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }
}
