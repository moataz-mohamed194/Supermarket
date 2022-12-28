import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color? color;
  final Color borderColor;
  final Color? textColor;
  final double? height;
  final String text;
  final void Function() onPressed;

  const ButtonWidget({
    super.key,
    this.color,
    this.borderColor = const Color(0xFF000000),
    this.textColor,
    this.height,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.only(top: 10.0),
      // width: 10,
      child: MaterialButton(
        onPressed:onPressed,
        elevation: 0,
        color: color,
        // shape: RoundedRectangleBorder(
        //   side:
        //   BorderSide(width: 3, color: borderColor, style: BorderStyle.solid),
        //   borderRadius: const BorderRadius.all(
        //     Radius.circular(40),
        //   ),
        // ),
        minWidth: 10,
        height: height,
        child: Center(
          child: Text(
            text.toString(),
            style: TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}