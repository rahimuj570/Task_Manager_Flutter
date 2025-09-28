import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/models/user_model.dart';

class AuthController {
  static const String _tokenKey = 'token';
  static const String _userDataKey = 'userData';

  static UserModel? userModel;
  static String? userToken;

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(_tokenKey, token);
    await sp.setString(_userDataKey, jsonEncode(UserModel.toJson(model)));
    userModel = model;
    userToken = token;
  }

  static Future<void> getUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString(_tokenKey);
    if (token != null) {
      UserModel model = UserModel.fromJson(
        json.decode(sp.getString(_userDataKey)!),
      );

      userModel = model;
      userToken = token;
    }
  }

  static Future<bool> checkLoggedin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(_tokenKey) != null;
  }

  static Future<void> removeLoggedin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    userModel = null;
    userToken = null;
  }
}
