import 'package:flutter/material.dart';

class TmAppBarInfoNotifier extends ChangeNotifier {
  String? photo;
  String? fullName;

  void setFullName(String newFullName) {
    fullName = newFullName;
    notifyListeners();
  }

  void setPhoto(String? newPhoto) {
    photo = newPhoto;
    notifyListeners();
  }
}
