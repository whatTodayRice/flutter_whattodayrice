import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required this.titleController,
    this.hintText,
    this.maxLength,
    this.inputType,
    this.inputFormatters,
  });

  final TextEditingController titleController;
  final String? hintText;
  final int? maxLength;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      style: AppTextStyle.regular14.copyWith(color: AppColor.black000000),
      keyboardType: inputType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(13),
        hintText: hintText,
        hintStyle: AppTextStyle.regular14.copyWith(color: AppColor.grayB2B2B2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.grayDCDCDC),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.black121212),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.grayDCDCDC),
        ),
      ),
    );
  }
}
