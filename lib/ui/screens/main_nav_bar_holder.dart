import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/custom_navbar_widget.dart';

class MainNavBarHolder extends StatefulWidget {
  const MainNavBarHolder({super.key});

  @override
  State<MainNavBarHolder> createState() => _MainNavBarHolderState();
}

class _MainNavBarHolderState extends State<MainNavBarHolder> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green),

      body: AppBackground(children: [
         
        ],
      ),
      bottomNavigationBar: CustomNavbarWidget(
        selectedDestination: _selectedIndex,
        clickDestination: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
