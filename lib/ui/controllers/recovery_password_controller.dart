import 'package:flutter/material.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';

class RecoveryPasswordController extends ChangeNotifier {
  //For email
  String? _sentPinMessageSuccess;
  String? get getSentPinMessage => _sentPinMessageSuccess;
  bool isEmailVerifying = false;

  //For Pin
  bool isPinVerifying = false;
  String? _verifyPinMessageSuccess;
  String? get getVerifyPinMessage => _verifyPinMessageSuccess;
  String? _verifyPinMessageError;
  String? get getVerifyPinMessageError => _verifyPinMessageError;

  //For Reset Password
  bool isPasswordReseting = false;
  String? _resetPasswordSuccessMessage;
  String? _resetPasswordErrorMessage;
  String? get getResetPasswordSuccessMessage => _resetPasswordSuccessMessage;
  String? get getResetPasswordErrorMessage => _resetPasswordErrorMessage;

  //To verify email and sent OTP to email
  Future<bool> recoveryVerifyEmail(String email) async {
    isEmailVerifying = true;
    notifyListeners();
    _sentPinMessageSuccess = null;
    bool success = true;
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.recoverVerifyEmail(email.trim()),
    );
    _sentPinMessageSuccess = apiResponse.responseData['data'];
    try {
      if (apiResponse.responseData['status'] == 'success') {}
    } catch (e, _) {
      success = false;
    }
    isEmailVerifying = false;
    notifyListeners();
    return success;
  }

  //To verify pin
  Future<bool> doVerifyPin(String email, String pin) async {
    isPinVerifying = true;
    notifyListeners();
    bool success = false;
    _verifyPinMessageError = null;
    _verifyPinMessageSuccess = null;

    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.recoveryVerifyPin(email, pin),
    );
    if (apiResponse.isuccess) {
      success = true;
      _verifyPinMessageSuccess = apiResponse.responseData['data'];
    } else {
      _verifyPinMessageError = apiResponse.responseData['data'];
    }
    isPinVerifying = false;
    notifyListeners();
    return success;
  }

  //To reset password
  Future<bool> doresetPassword(Map<String, dynamic> body) async {
    isPasswordReseting = true;
    notifyListeners();
    _resetPasswordErrorMessage = null;
    _resetPasswordSuccessMessage = null;
    bool success = false;
    ApiResponse apiResponse = await ApiCalller.postRequest(
      url: Urls.resetPassword,
      body: body,
    );
    if (apiResponse.isuccess) {
      success = true;
      _resetPasswordSuccessMessage = apiResponse.responseData['data'];
    } else {
      _resetPasswordErrorMessage = apiResponse.responseData['data'];
    }
    isPasswordReseting = false;
    notifyListeners();
    return success;
  }
}
