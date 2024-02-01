import 'package:flutter/material.dart';

class MyTextInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const MyTextInputField(
      {Key? key, required this.hintText, required this.controller})
      : super(key: key);

  @override
  State<MyTextInputField> createState() => _MyTextInputFieldState();
}

class _MyTextInputFieldState extends State<MyTextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 38),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            isCollapsed: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          cursorWidth: 1,
        ),
      ),
    );
  }
}
