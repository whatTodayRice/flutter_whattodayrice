import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/modules/board/widget/FAB/fab_item.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({super.key, required this.item});

  final FABItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132.w,
      height: 54.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: AppColor.homeOptionBackgroundColor,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item.assetPath,
              width: 28.w,
              height: 28.w,
            ),
            SizedBox(width: 4.w),
            Text(
              item.mainButtonText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16.w),
            ),
          ],
        ),
      ),
    );
  }
}
