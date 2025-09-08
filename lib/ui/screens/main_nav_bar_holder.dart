import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/custom_navbar_widget.dart';
import 'package:todo_app/ui/widgets/tm_app_bar.dart';

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
      appBar: TmAppBar(),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   selectedItemColor: Colors.green,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.note_add),
      //       label: 'New Task',
      //     ),

      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.note_add),
      //       label: 'New Task',
      //     ),
      //   ],
      // ),
    );
  }
}
