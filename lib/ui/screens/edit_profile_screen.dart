import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/data/models/user_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/controllers/auth_controller.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/show_toast.dart';
import 'package:todo_app/ui/widgets/tm_app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const name = "edit_profile_screen";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

ImagePicker _imagePicker = ImagePicker();
String _photoPlaceholder = "No Photo Selected";

class _EditProfileScreenState extends State<EditProfileScreen> {
  // ImagePicker imagePicker = imagePicker();
  XFile? photo;
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowPassword = false;
  bool isUpdating = false;

  late final UserModel user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = AuthController.userModel!;

    _emailTEC.text = user.email;
    _firstNameTEC.text = user.firstName;
    _lastNameTEC.text = user.lastName;
    _emailTEC.text = user.email;
    _mobileTEC.text = user.mobile;
  }

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
                      key: _formKey,
                      child: Column(
                        spacing: 10,
                        children: [
                          GestureDetector(
                            onTap: !isUpdating ? _getImage : null,
                            child: Container(
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
                                  Expanded(
                                    child: Text(
                                      maxLines: 1,

                                      _photoPlaceholder,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _emailTEC,
                            enabled: false,
                            decoration: InputDecoration(label: Text("Email")),
                          ),
                          TextFormField(
                            enabled: !isUpdating,
                            controller: _firstNameTEC,
                            decoration: InputDecoration(
                              label: Text("First Name"),
                            ),
                            validator: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Must input First name";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                          ),
                          TextFormField(
                            enabled: !isUpdating,
                            controller: _lastNameTEC,
                            decoration: InputDecoration(
                              label: Text("Last Name"),
                            ),
                            validator: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Must input Last name";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                          ),
                          TextFormField(
                            enabled: !isUpdating,
                            controller: _mobileTEC,
                            decoration: InputDecoration(label: Text("Mobile")),
                            validator: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Must input Mobile number";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                          ),
                          TextFormField(
                            enabled: !isUpdating,
                            controller: _passwordTEC,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                // constraints: BoxConstraints(maxHeight: 0),
                                // padding: EdgeInsets.all(0),
                                icon: Icon(
                                  isShowPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 18,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isShowPassword = !isShowPassword;
                                  });
                                },
                              ),
                              label: Text("Password (Optional)"),
                            ),
                            obscureText: !isShowPassword,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return null;
                              } else if (value!.length < 7) {
                                return "Length of the Password must be atleast 7";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          FilledButton(
                            onPressed: !isUpdating
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      _updateProfle();
                                    }
                                  }
                                : null,
                            child: Text("Update"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isUpdating,
              child: Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    photo = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _photoPlaceholder = photo!.name;
      });
    }
  }

  Future<void> _updateProfle() async {
    isUpdating = true;
    setState(() {});

    Map<String, dynamic> body = {
      "photo": user.photo,
      "_id": user.id,
      "email": _emailTEC.text.trim(),
      "firstName": _firstNameTEC.text.trim(),
      "lastName": _lastNameTEC.text.trim(),
      "mobile": _mobileTEC.text.trim(),
    };
    if (photo != null) {
      Uint8List bytes = await photo!.readAsBytes();
      String encodedPhoto = base64Encode(bytes);
      body['photo'] = encodedPhoto;
    }

    if (_passwordTEC.text.trim().isNotEmpty) {
      body['password'] = _passwordTEC.text.trim();
    }

    final ApiResponse apiResponse = await ApiCalller.postRequest(
      url: Urls.updateProfile,
      body: body,
    );

    if (apiResponse.isuccess) {
      _passwordTEC.clear();
      await AuthController.updateUserData(UserModel.fromJson(body));
      showSnackBar(context, "Profile Updated Successfully!", ToastType.success);
    } else {
      showSnackBar(context, "Something Went Wrong!", ToastType.error);
    }
    setState(() {
      isUpdating = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _mobileTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }
}
