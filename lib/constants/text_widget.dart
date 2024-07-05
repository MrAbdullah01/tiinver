import 'package:flutter/material.dart';

class TextWidget1 extends StatelessWidget {
  const TextWidget1(
      {super.key,
        required this.text,
        required this.fontSize,
        required this.fontWeight,
        required this.isTextCenter,
        this.maxLines = 1,
        required this.textColor});
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final bool isTextCenter;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: isTextCenter == true ? TextAlign.center: TextAlign.justify,
      style: TextStyle(
          fontSize: fontSize, fontWeight: fontWeight, color: textColor),
    );
  }
}
