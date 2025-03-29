import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

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
    this.borderColor,
    this.isRequiredFocusedBorder,
    this.isRequiredEnabledBorder,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final Widget? suffixIcon;
  final InputBorder? inputBorder;
  final bool isObscure;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;
  final Color? borderColor;
  final bool? isRequiredFocusedBorder;
  final bool? isRequiredEnabledBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor ?? AppColor.primary,
          width: 1.2,
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: textStyle,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintTextStyle,
          suffixIcon: suffixIcon,
          border: inputBorder,
          enabledBorder: isRequiredEnabledBorder != null
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.grayC1C1C1, width: 1.2),
                )
              : InputBorder.none,
          focusedBorder: isRequiredFocusedBorder != null
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary, width: 1.2),
                )
              : InputBorder.none,
        ),
        cursorColor: AppColor.primary,
      ),
    );
  }
}
