import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.suffixIcon,
    this.isObscure = false,
    this.inputBorder,
    required this.textStyle,
    required this.hintTextStyle,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final Widget? suffixIcon;
  final InputBorder? inputBorder;
  final bool isObscure;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstant.primary, width: 1.2),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: textStyle,
        obscureText: isObscure,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: hintText,
          hintStyle: hintTextStyle,
          border: inputBorder ?? InputBorder.none,
          suffixIcon: suffixIcon,
        ),
        cursorColor: ColorConstant.primary,
      ),
    );
  }
}
