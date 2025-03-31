import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

class CreatePostSubmitButton extends StatelessWidget {
  const CreatePostSubmitButton({super.key, required this.isButtonEnabled, this.onTap});

  final bool isButtonEnabled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final viewPaddingBottom = MediaQueryData.fromView(View.of(context)).viewPadding.bottom;

    return GestureDetector(
      onTap: isButtonEnabled ? onTap : null,
      child: Container(
        margin: EdgeInsets.only(bottom: viewPaddingBottom != 0 ? viewPaddingBottom : 30),
        width: double.infinity,
        height: 46.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isButtonEnabled ? AppColor.orange5 : AppColor.grayDCDCDC,
        ),
        child: Center(
          child: Text("작성완료", style: AppTextStyle.bold15.copyWith(color: AppColor.white1)),
        ),
      ),
    );
  }
}
