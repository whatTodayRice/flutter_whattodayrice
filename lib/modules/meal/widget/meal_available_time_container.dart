import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

class MealAvailableTimeContainer extends StatelessWidget {
  const MealAvailableTimeContainer({
    super.key,
    required this.availableMealTime,
    required this.isActive,
  });

  final String availableMealTime;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isActive ? AppColor.secondary : AppColor.gray4,
      ),
      child: Text(
        availableMealTime,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 11,
              color: isActive ? AppColor.primary : AppColor.gray5,
            ),
      ),
    );
  }
}
