import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message,
  ToastType toastType,
) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: toastType == ToastType.success
          ? Colors.green
          : Colors.red,
      content: Text(message),
    ),
  );
}

enum ToastType { success, error }
