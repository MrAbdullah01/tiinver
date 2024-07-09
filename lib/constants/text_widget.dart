import 'package:flutter/material.dart';
import 'package:tiinver_project/constants/colors.dart';

class TextWidget1 extends StatelessWidget {
  const TextWidget1(
      {super.key,
        required this.text,
        required this.fontSize,
        required this.fontWeight,
        required this.isTextCenter,
        this.maxLines,
        this.decoration,
        this.overFlow,
        required this.textColor});
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final bool isTextCenter;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextOverflow? overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? null,
      overflow: overFlow,
      textAlign: isTextCenter == true ? TextAlign.center: TextAlign.justify,
      style: TextStyle(
          fontSize: fontSize, fontWeight: fontWeight,
          color: textColor,decoration: decoration,
        decorationColor: themeColor,decorationThickness: 2
      ),
    );
  }
}
