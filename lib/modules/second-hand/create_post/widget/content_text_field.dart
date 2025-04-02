import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

class ContentTextField extends StatelessWidget {
  const ContentTextField(
      {super.key, required this.contentController, required this.hintText, this.maxLength, this.focusNode});

  final TextEditingController contentController;
  final FocusNode? focusNode;
  final String hintText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contentController,
      focusNode: focusNode,
      style: AppTextStyle.regular14.copyWith(color: AppColor.black000000),
      expands: true,
      maxLines: null,
      maxLength: maxLength,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.regular14.copyWith(color: AppColor.grayB2B2B2),
        contentPadding: const EdgeInsets.all(14),
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
