import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';

class MealTimeTextRow extends StatelessWidget {
  const MealTimeTextRow(
      {super.key,
      required this.width,
      required this.height,
      required this.mealType,
      required this.mealTime});

  final String mealType;
  final double width;
  final double height;
  final String mealTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        kMealCategoryText(mealType: mealType, width: width),
        const SizedBox(
          width: 8,
        ),
        kMealCategoryIcon(
          width: width,
          height: height,
          mealType: mealType,
        ),
        const SizedBox(
          width: 10,
        ),
        MealAvailableTimeText(
          mealTime: mealTime,
        ),
      ],
    );
  }
}
