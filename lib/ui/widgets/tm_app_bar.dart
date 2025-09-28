import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/edit_profile_screen.dart';

class TmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TmAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    void _gotoEditProfile() {
      if (ModalRoute.of(context)?.settings.name != EditProfileScreen.name) {
        Navigator.pushNamed(context, EditProfileScreen.name);
      }
    }

    return AppBar(
      leadingWidth: 30,
      backgroundColor: Colors.green,

      title: Row(
        spacing: 8,
        children: [
          GestureDetector(
            onTap: _gotoEditProfile,
            child: CircleAvatar(
              foregroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/89479874?v=4",
              ),
              onForegroundImageError: (exception, stackTrace) =>
                  debugPrint("error dp " + exception.toString()),
              child: Icon(Icons.error),
            ),
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
