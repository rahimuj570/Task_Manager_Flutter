import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/models/user_model.dart';

class AuthController extends ChangeNotifier {
  final String _tokenKey = 'token';
  final String _userDataKey = 'userData';

  static UserModel? userModel;
  static String? userToken;
  String fullName() =>
      "${userModel?.firstName ?? "Md."} ${userModel?.lastName ?? "Rahimujjaman"}";

  Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(_tokenKey, token);
    await sp.setString(_userDataKey, jsonEncode(UserModel.toJson(model)));
    userModel = model;
    userToken = token;
  }

  Future<void> getUserData() async {
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

  Future<bool> checkLoggedin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(_tokenKey) != null;
  }

  static Future<void> removeLoggedin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    userModel = null;
    userToken = null;
  }

  Future<void> updateUserData(UserModel model) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(_userDataKey, jsonEncode(UserModel.toJson(model)));
    userModel = model;
  }
}
