import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/tm_app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const name = "edit_profile_screen";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
      body: SafeArea(
        child: AppBackground(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Update Profile",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 16),
                    Form(
                      child: Column(
                        spacing: 10,
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Row(
                              spacing: 8,
                              children: [
                                Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                    color: Colors.black54,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Photos",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "No Photo Selected",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(label: Text("Email")),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              label: Text("First Name"),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              label: Text("Last Name"),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(label: Text("Mobile")),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              label: Text("Password"),
                            ),
                          ),
                          FilledButton(onPressed: () {}, child: Text("Update")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
