import '../../presentation/App.dart';
import 'package:flutter/material.dart';

class ToolShowToast {
  static void show(String message) {
    ScaffoldMessenger.of(App.navigatorKey.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(App.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.green.withOpacity(0.9),
        duration: Duration(seconds: 2),
        elevation: 2,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showError(String message) {
    ScaffoldMessenger.of(App.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        elevation: 2,
        behavior: SnackBarBehavior.floating,
      ),
    );
    print('ebd show');
  }
}
