import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tiinver_project/constants/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController inputController;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color? fillColor;
  final int? maxLines, maxLength;
  var prefixIcon;
  var suffixIcon;
  double bdRadius;
  bool autofocus;

  InputField({
    super.key,
    required this.inputController,
    this.type,
    this.maxLines = 1,
    this.textInputAction,
    this.hintText,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.bdRadius = 18,
    this.autofocus = false,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      textInputAction: textInputAction,
      keyboardType: type,
      autofocus: autofocus,
      style: TextStyle(
        fontSize: 12.dp,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: themeColor,
      controller: inputController,
      maxLength: maxLength,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconColor: darkGreyColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        fillColor: fillColor ?? tileColor,
        filled: true,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide:  BorderSide(
            color: tileColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(bdRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: tileColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(bdRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: tileColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(bdRadius),
        ),
      ),
    );
  }
}