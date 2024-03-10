import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/models/meal.dart';
import 'package:flutter_whattodayrice/theme/constants.dart';

class MealTimeTextRow extends StatelessWidget {
  const MealTimeTextRow(
      {super.key, required this.mealType, required this.mealTime});

  final MealType mealType;
  final String mealTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          mealTypes[mealType],
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          width: 8.w,
        ),
        MealCategoryIcon(
          mealType: mealType,
        ),
        SizedBox(
          width: 10.w,
        ),
        MealAvailableTimeText(
          mealTime: mealTime,
        ),
      ],
    );
  }
}
