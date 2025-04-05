import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_meal_type.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_menu_type.dart';
import 'package:flutter_whattodayrice/modules/meal/widget/menu_card/menu_card_menu_row.dart';
import 'package:flutter_whattodayrice/modules/meal/widget/menu_card/menu_card_title_row.dart';

class MenuCard extends StatelessWidget {
  final MealType mealType;
  final String normalMenu;
  final String? premiumMenu;
  final String? takeOut;
  final String availableMealTime;
  final bool isActive;
  final bool isWeekend;

  const MenuCard({
    super.key,
    this.takeOut,
    this.premiumMenu,
    required this.mealType,
    required this.normalMenu,
    required this.isActive,
    required this.isWeekend,
    required this.availableMealTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isActive ? AppColor.secondary : Colors.transparent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuCardTitleRow(mealType: mealType, isActive: isActive, availableMealTime: availableMealTime),
              SizedBox(height: 18.h),
              MenuCardMenuRow(menuType: MenuType.normal, menu: normalMenu),
              SizedBox(height: 12.h),
              if (!isWeekend && takeOut != null)
                MenuCardMenuRow(menuType: MenuType.takeOut, menu: takeOut!)
              else if (!isWeekend && premiumMenu != null)
                MenuCardMenuRow(menuType: MenuType.premium, menu: premiumMenu!),
            ],
          ),
        ),
      ),
    );
  }
}
