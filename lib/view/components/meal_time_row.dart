import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';

class MealTimeTextRow extends StatelessWidget {
  const MealTimeTextRow({
    super.key,
    required this.mainScreenWidth,
    required this.mainScreenHeight,
  });

  final double mainScreenWidth;
  final double mainScreenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const kMealCategoryText(),
        const SizedBox(
          mainScreenWidth: 8,
        ),
        kMealCategoryIcon(
            mainScreenWidth: mainScreenWidth,
            mainScreenHeight: mainScreenHeight),
        const SizedBox(
          mainScreenWidth: 10,
        ),
        const kMealAvailableTimeText(),
      ],
    );
  }
}
