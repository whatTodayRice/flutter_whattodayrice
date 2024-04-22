import 'package:flutter_whattodayrice/common/theme/constants.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';

//식당 이용시간 받아오는 메서드
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
