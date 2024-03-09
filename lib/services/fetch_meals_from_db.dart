import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/providers/dto_user_info.dart';
import 'package:flutter_whattodayrice/services/fetch_happy_meals.dart';
import 'package:flutter_whattodayrice/services/fetch_sejong_meals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dormitory.dart';
import '../models/meal.dart';
import '../providers/dormitory_provider.dart';

Future<List<MealData?>> fetchMealDataFromDB(DormitoryType dormitoryType) async {
  List<MealData?> weeklyMeals = [];

  final dormitory =  await  readDormitorySharedPreferencesData();
  print("fetchMealData에서 받아온 기숙사 값: $dormitory");


  try {
    switch (dormitoryType) {
      case DormitoryType.sejong1:
        weeklyMeals = await fetchSejongMeals();
        break;
      case DormitoryType.sejong2:
        weeklyMeals = await fetchSejongMeals();
        break;
      case DormitoryType.happiness:
        weeklyMeals = await fetchHappyMeals();
        break;
    }
    return weeklyMeals;
    // if (dormitoryType == DormitoryType.happiness) {
    //   weeklyMeals = await fetchHappyMeals();
    // } else {
    //   weeklyMeals = await fetchSejongMeals();
    // }
    return weeklyMeals;
  } catch (e) {
    throw Exception("없음");
  }
}
