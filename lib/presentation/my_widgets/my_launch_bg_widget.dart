import 'package:flutter/material.dart';

class MyLaunchBGWidget extends StatelessWidget {
  BoxDecoration orbDecoration = BoxDecoration(
    shape: BoxShape.circle,
    gradient: RadialGradient(
      colors: [
        Color(0xFFBFCDE0).withOpacity(0.9),
        Color(0xFFBFCDE0).withOpacity(0.15),
        Color(0xFFBFCDE0).withOpacity(0.1),
        Color(0xFFBFCDE0).withOpacity(0.05),
        Colors.transparent,
      ],
      stops: [0.05, 0.45, 0.55, 0.7, 1.0],
      center: Alignment.center,
      radius: 1,
    ),
  );

  MyLaunchBGWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            transform: Matrix4.identity()..translate(-24.0, -28.0),
            decoration: orbDecoration,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              transform: Matrix4.identity()..translate(80.0, 60.0),
              width: 180,
              height: 180,
              decoration: orbDecoration,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              transform: Matrix4.identity()..translate(-85.0, 290.0),
              width: 180,
              height: 180,
              decoration: orbDecoration,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              transform: Matrix4.identity()..translate(110.0, 400.0),
              width: 180,
              height: 180,
              decoration: orbDecoration,
            ),
          ),
          Container(
            color: Color(0xFF1E1E24).withOpacity(0.75),
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
