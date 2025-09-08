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
      appBar: AppBar(
        leadingWidth: 30,
        backgroundColor: Colors.green,

        title: Row(
          spacing: 8,
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/89479874?v=4",
              ),
              onForegroundImageError: (exception, stackTrace) =>
                  debugPrint("error dp " + exception.toString()),
              child: Icon(Icons.error),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rahimujjaman",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
                Text(
                  "rahimuj570@gmail.com",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
        foregroundColor: Colors.white,
      ),

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
