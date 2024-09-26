import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_meal_type.dart';
import 'package:flutter_whattodayrice/modules/home/widget/meal_available_time_container.dart';
import 'package:flutter_whattodayrice/modules/home/widget/meal_type_icon.dart';

class MenuCardTitleRow extends StatelessWidget {
  const MenuCardTitleRow({
    super.key,
    required this.mealType,
    required this.isActive,
    required this.availableMealTime,
  });

  final MealType mealType;
  final bool isActive;
  final String availableMealTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MealTypeIcon(mealType: mealType, isActive: isActive),
        const SizedBox(width: 8),
        Text(mealType.title, style: Theme.of(context).textTheme.titleSmall!),
        const SizedBox(width: 8),
        MealAvailableTimeContainer(isActive: isActive, availableMealTime: availableMealTime),
      ],
    );
  }
}
