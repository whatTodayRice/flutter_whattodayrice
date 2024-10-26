import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:intl/intl.dart';

class DateCell extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateCell({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dayOfWeek = DateFormat('E', 'ko_KR').format(date);
    final dayOfMonth = date.day.toString();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54.w,
        height: 82.h,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.orange3 : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayOfWeek,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.w, color: AppColor.gray6),
            ),
            const SizedBox(height: 4),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: isSelected ? AppColor.orange4 : AppColor.homeOptionBackgroundColor,
                borderRadius: BorderRadius.circular(36),
              ),
              child: Center(
                child: Text(
                  dayOfMonth,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16.w, color: isSelected ? Colors.white : AppColor.gray7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
