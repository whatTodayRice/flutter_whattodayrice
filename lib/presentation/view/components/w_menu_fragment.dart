import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/common/const/meal_available_time.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/presentation/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/presentation/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_meal_container.dart';

enum WeekPeriod { weekday, weekend }

class MenuFragment extends ConsumerWidget {
  const MenuFragment({
    super.key,
    required this.mealData,
  });

  final MealData mealData;

  bool isWeekendInKorea() {
    // 한국 시간 기준으로 현재 날짜와 시간을 가져옴
    DateTime now = DateTime.now().toUtc().add(const Duration(hours: 9));

    // 6 (토요일), 7 (일요일)인 경우 주말
    return now.weekday == 6 || now.weekday == 7;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          CalenderRow(mealDate: mealData.date),
          SizedBox(height: screenHeight * 0.039),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: !isWeekendInKorea() ? happyBreakfastWeekdayTime : happyBreakfastWeekendTime,
              mealType: MealType.breakfast,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(content: '일반 : ${mealData.breakfast}\n\nTAKE - OUT : ${mealData.takeout}'),
          ),
          SizedBox(height: screenHeight * 0.03),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: !isWeekendInKorea() ? happyLunchWeekdayTime : happyLunchWeekendTime,
              mealType: MealType.lunch,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(content: mealData.lunch),
          ),
          SizedBox(height: screenHeight * 0.03),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: !isWeekendInKorea() ? happyDinnerWeekdayTime : happyDinnerWeekendTime,
              mealType: MealType.dinner,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(content: mealData.dinner),
          ),
        ],
      ),
    );
  }
}
