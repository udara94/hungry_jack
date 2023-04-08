import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar(
      {Key? key,
      this.fontSize,
      required this.backgroundColor,
      required this.message})
      : super(key: key);
  final double? fontSize;
  final Color backgroundColor;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TextStyle(fontSize: fontSize),
      ),
      duration: const Duration(milliseconds: 2000),
    );
  }
}
