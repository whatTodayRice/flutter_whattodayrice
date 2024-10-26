import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.assetPath,
    required this.content,
    required this.onTap,
  });

  final String assetPath;
  final String content;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 130,
        child: Center(
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(assetPath, width: 24, height: 24),
                SizedBox(width: 8.h),
                Text(
                  content,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600, color: AppColor.orange6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
