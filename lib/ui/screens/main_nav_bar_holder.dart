import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/task_screens/new_task_screen.dart';
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

  List<Widget> taskScreens = [
    NewTaskScreen(),
    NewTaskScreen(),
    NewTaskScreen(),
    NewTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
      body: AppBackground(children: [taskScreens[_selectedIndex]]),

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
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () {},
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
