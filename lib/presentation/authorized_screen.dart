import 'package:flutter/material.dart';
import 'package:jwt_test_task/presentation/my_widgets/my_launch_bg_widget.dart';

class AuthorizedScreen extends StatelessWidget {
  const AuthorizedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E24),
      body: Stack(
        children: [
          MyLaunchBGWidget(),
          Center(
            child: Text(
              'Authorized',
              style: TextStyle(color: Colors.white, fontSize: 46),
            ),
          )
        ],
      ),
    );
  }
}
