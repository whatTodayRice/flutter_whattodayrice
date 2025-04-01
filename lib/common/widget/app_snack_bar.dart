import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

abstract class AppSnackBar {
  static SnackBar text(String content) => SnackBar(
        content: Text(content, style: AppTextStyle.regular11.copyWith(color: AppColor.whiteF8F8F8)),
        backgroundColor: AppColor.orangeFF823B,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.startToEnd,
      );
}
