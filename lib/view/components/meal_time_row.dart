import 'package:flutter/material.dart';

class MealTimeTextRow extends StatelessWidget {
  const MealTimeTextRow({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const kMealCategoryText(),
        const SizedBox(
          width: 8,
        ),
        kMealCategoryIcon(width: width, height: height),
        const SizedBox(
          width: 10,
        ),
        const kMealAvailableTimeText(),
      ],
    );
  }
}
