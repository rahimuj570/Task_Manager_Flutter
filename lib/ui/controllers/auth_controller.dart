import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/models/user_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';

class AuthController extends ChangeNotifier {
  final String _tokenKey = 'token';
  final String _userDataKey = 'userData';
  String? _loginErrorMessage;
  String? get getLoginErrorMessage => _loginErrorMessage;
  bool isLoginProcessing = false;
  bool isRegistrationProcessing = false;
  String? _registrationErrorMessage;
  String? get getRegistrationErrorMessage => _registrationErrorMessage;

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

  Future<bool> updateUserData(Map<String, dynamic> body) async {
    bool success = false;
    final ApiResponse apiResponse = await ApiCalller.postRequest(
      url: Urls.updateProfile,
      body: body,
    );
    if (apiResponse.isuccess) {
      success = true;
      UserModel um = UserModel.fromJson(body);
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString(_userDataKey, jsonEncode(UserModel.toJson(um)));
      userModel = um;
      notifyListeners();
    }
    return success;
  }

  Future<bool> doLogin(Map<String, dynamic> body) async {
    _loginErrorMessage = null;
    isLoginProcessing = true;
    notifyListeners();
    bool success = false;

    ApiResponse apiResponse = await ApiCalller.postRequest(
      url: Urls.userLogin,
      body: body,
    );

    if (apiResponse.statusCode == 200 &&
        apiResponse.responseData['status'] == 'success') {
      success = true;
      saveUserData(
        UserModel.fromJson(apiResponse.responseData['data']),
        apiResponse.responseData['token'],
      );
    } else {
      _loginErrorMessage = apiResponse.errorMessage;
    }
    isLoginProcessing = false;
    notifyListeners();
    return success;
  }

  Future<bool> doUserRegistration(Map<String, dynamic> body) async {
    isRegistrationProcessing = true;
    notifyListeners();
    bool success = true;

    ApiResponse apiResponse = await ApiCalller.postRequest(
      url: Urls.userRegistration,
      body: body,
    );

    if (apiResponse.responseData['status'] == 'fail') {
      success = false;
      _registrationErrorMessage = apiResponse.responseData['data'];
    }
    isRegistrationProcessing = false;
    notifyListeners();
    return success;
  }
}
