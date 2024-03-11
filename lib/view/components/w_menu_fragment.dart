import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/models/meal.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/theme/constants.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/view/components/w_meal_container.dart';

class MenuFragment extends ConsumerWidget {
  const MenuFragment(
      {super.key, required this.meal, required this.date, required this.index});

  final MealData? meal;
  final int index;
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final dormitoryType = ref.watch(dormitoryProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          CalenderRow(mealDate: meal!.date),
          SizedBox(
            height: screenHeight * 0.039,
          ),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: getAvailableTimeText(
                  dormitoryType: dormitoryType,
                  mealType: MealType.breakfast,
                  date: date,
                  index: index),
              mealType: MealType.breakfast,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(
              content: (dormitoryType == DormitoryType.happiness)
                  ? '일반 : ${meal!.breakfast}\n\nTAKE - OUT : ${meal!.takeout}'
                  : '${meal!.breakfast}',
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: getAvailableTimeText(
                  dormitoryType: dormitoryType,
                  mealType: MealType.lunch,
                  date: date,
                  index: index),
              mealType: MealType.lunch,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(
              content: '${meal!.lunch}',
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: getAvailableTimeText(
                  dormitoryType: dormitoryType,
                  mealType: MealType.dinner,
                  date: date,
                  index: index),
              mealType: MealType.dinner,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(
              content: '${meal!.dinner}',
            ),
          ),
        ],
      ),
    );
  }
}

String getAvailableTimeText(
    {required DormitoryType dormitoryType,
    required MealType mealType,
    required DateTime date,
    required int index}) {
  DateTime modifiedDate = date.add(Duration(days: index));

  switch (mealType) {
    case (MealType.breakfast):
      if (dormitoryType == DormitoryType.sejong1 ||
          dormitoryType == DormitoryType.sejong2) {
        if (modifiedDate.isAfter(DateTime(2023, 6, 27)) &&
            modifiedDate.isBefore(DateTime(2023, 8, 31))) {
          return sejongVacationBreakfastTime;
        } else {
          return sejongBreakfastTime;
        }
      } else {
        if (isWeekday(modifiedDate)) {
          return happyBreakfastWeekTime;
        } else {
          return happyBreakfastTime;
        }
      }
    case (MealType.lunch):
      if (dormitoryType == DormitoryType.sejong1 ||
          dormitoryType == DormitoryType.sejong2) {
        if (modifiedDate.isAfter(DateTime(2023, 6, 27)) &&
            modifiedDate.isBefore(DateTime(2023, 8, 31))) {
          return sejongVacationLunchTime;
        } else {
          return sejongLunchTime;
        }
      } else {
        if (isWeekday(modifiedDate)) {
          return happyLunchWeekTime;
        } else {
          return happyLunchTime;
        }
      }
    case (MealType.dinner):
      if (dormitoryType == DormitoryType.sejong1 ||
          dormitoryType == DormitoryType.sejong2) {
        if (modifiedDate.isAfter(DateTime(2023, 6, 27)) &&
            modifiedDate.isBefore(DateTime(2023, 8, 31))) {
          return sejongVacaitonDinnerTime;
        } else {
          return sejongDinnerTime;
        }
      } else {
        if (isWeekday(modifiedDate)) {
          return happyDinnerWeekTime;
        } else {
          return happyDinnerTime;
        }
      }
  }
}

bool isWeekday(DateTime modifiedDate) {
  return modifiedDate.weekday >= DateTime.monday &&
      modifiedDate.weekday <= DateTime.friday;
}
