import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final Stream? textStream;
  final ValueChanged<String>? textChange;
  final String? hintText;
  final TextInputType? inputType;
  final Icon? textIcon;
  final String? errorText;
  final Color? cursorColor;
  final Color? textStyleColor;
  final Color borderSideColor;
  final bool obscure;
  final String? oldData;
  final TextStyle? hintStyle;

  const TextFieldWidget({
    super.key,
    this.textStream,
    this.textChange,
    this.hintText,
    this.inputType,
    this.textIcon,
    this.errorText,
    this.cursorColor,
    this.textStyleColor,
    this.borderSideColor = const Color(0xFF000000),
    this.obscure = false,
    this.oldData,
    this.hintStyle});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
      child: StreamBuilder(
          stream: textStream,
          builder: (context, snapshot) {
            return TextFormField(
                textAlign: TextAlign.right,
                style: TextStyle(color: textStyleColor),
                cursorColor: cursorColor,
                autofocus: false,
                keyboardType: inputType,
                obscureText: obscure,
                onChanged: textChange,
                decoration: InputDecoration(
                  prefixIcon: textIcon,
                  hintText: "$hintText",
                  helperStyle: TextStyle(
                    color: textStyleColor,
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: hintStyle,
                  errorText: errorText,
                ),
                initialValue: oldData);
          }),
    );
  }
}