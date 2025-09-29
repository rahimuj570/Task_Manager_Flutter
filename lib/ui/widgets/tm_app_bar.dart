import 'package:flutter/material.dart';
import 'package:todo_app/ui/controllers/auth_controller.dart';
import 'package:todo_app/ui/screens/edit_profile_screen.dart';
import 'package:todo_app/ui/screens/login_screen.dart';

class TmAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TmAppBar({super.key});

  @override
  State<TmAppBar> createState() => _TmAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TmAppBarState extends State<TmAppBar> {
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
                AuthController.fullName ?? "Rahimujjaman",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              Text(
                AuthController.userModel?.email ?? "rahimuj570@gmail.com",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      actions: [IconButton(onPressed: _logout, icon: Icon(Icons.logout))],
      foregroundColor: Colors.white,
    );
  }

  Future<void> _logout() async {
    await AuthController.removeLoggedin();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.name,
      (predicate) => true,
    );
  }
}
