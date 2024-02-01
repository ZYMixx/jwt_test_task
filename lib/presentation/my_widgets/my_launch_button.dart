import 'package:flutter/material.dart';

class MyLaunchButton extends StatefulWidget {
  final String text;
  Color? textColor;
  Color? color;
  String? iconPath;
  final VoidCallback callBack;

  MyLaunchButton({
    Key? key,
    required this.text,
    required this.callBack,
    this.color,
    this.textColor,
    this.iconPath,
  }) : super(key: key);

  @override
  State<MyLaunchButton> createState() => _MyLaunchButtonState();
}

class _MyLaunchButtonState extends State<MyLaunchButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.callBack.call(),
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: ShapeDecoration(
          color: widget.color ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.iconPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Image.asset(
                  widget.iconPath!,
                  height: 40,
                  width: 40,
                ),
              ),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: widget.textColor ?? Colors.black,
              ),
            ),
            if (widget.iconPath != null)
              SizedBox(
                width: 20,
              )
          ],
        ),
      ),
    );
  }
}
