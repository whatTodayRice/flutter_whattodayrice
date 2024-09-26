import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_meal_type.dart';

class MealTypeIcon extends StatelessWidget {
  const MealTypeIcon({
    super.key,
    required this.mealType,
    required this.isActive,
  });

  final MealType mealType;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final selectedIcon = mealIcons[mealType];
    return Icon(
      selectedIcon,
      size: 18.w,
      color: isActive ? AppColor.primary : Colors.black,
    );
  }
}

const Map<dynamic, IconData> mealIcons = {
  MealType.breakfast: Icons.wb_twilight_rounded,
  MealType.lunch: Icons.sunny,
  MealType.dinner: Icons.mode_night_rounded,
};
