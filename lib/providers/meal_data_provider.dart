import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/models/meal.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/services/fetch_meals_from_db.dart';

final mealDataProvider = FutureProvider<List<MealData?>>(
  (ref) async {
    //todo : 여기서 shared preferences에 저장된 기숙사값을 불러오고 fetchMeal

    DormitoryType dormitoryType = ref.watch(dormitoryProvider);
    try {
      final weeklyMeals = await fetchMealDataFromDB(dormitoryType);
      return weeklyMeals;
    } catch (error) {
      const Text('식단을 받아오는 데 에러가 발생했어요');
      return [];
    }
  },
);

final initialPageIndexProvider = StateProvider(
  (ref) {
    DormitoryType dormitoryType = ref.watch(dormitoryProvider);
    DateTime userAccessTime = DateTime.now();
    int initialPageIndex =
        getUserAccessDatePageIndex(userAccessTime, dormitoryType);
    return initialPageIndex;
  },
);

int getUserAccessDatePageIndex(DateTime dateTime, DormitoryType dormitoryType) {
  int userAccessWeekday = dateTime.weekday;

  if (dormitoryType == DormitoryType.happiness) {
    userAccessWeekday = userAccessWeekday - 1;
  } else {
    if (userAccessWeekday == 7) {
      userAccessWeekday = userAccessWeekday - 7;
    }
  }
  return userAccessWeekday;
}
