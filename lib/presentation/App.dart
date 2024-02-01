import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jwt_test_task/data/services/service_shared_preferences.dart';
import 'launch_screen.dart';

class App {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static void start() {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      navigatorKey = GlobalKey<NavigatorState>();
      await ServiceSharedPreferences.init();
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: true,
          navigatorKey: navigatorKey,
          home: LaunchScreen(),
        ),
      );
    }, (error, stackTrace) {
      print('Error occurred: $error');
      print('Stack trace: $stackTrace');
    });
  }
}
