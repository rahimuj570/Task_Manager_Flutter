import 'package:flutter/material.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';

class RecoveryPasswordController extends ChangeNotifier {
  String? _sentPinStatus;
  String? get getSentPinMessage => _sentPinStatus;
  bool isEmailVerifying = false;
  //To verify email and sent OTP to email
  Future<bool> recoveryVerifyEmail(String email) async {
    isEmailVerifying = true;
    notifyListeners();
    _sentPinStatus = null;
    bool success = true;
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.recoverVerifyEmail(email.trim()),
    );
    _sentPinStatus = apiResponse.responseData['data'];
    try {
      if (apiResponse.responseData['status'] == 'success') {}
    } catch (e, _) {
      success = false;
    }
    isEmailVerifying = false;
    notifyListeners();
    return success;
  }
}
