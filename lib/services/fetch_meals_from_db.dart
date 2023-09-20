import 'dart:io';
import 'package:flutter_whattodayrice/services/fetch_happy_meals.dart';
import 'package:flutter_whattodayrice/services/fetch_sejong_meals.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/dormitory.dart';
import '../models/meal.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:path/path.dart' as p;

Future<List<MealData?>> fetchMealDataFromDB(
  DateTime now,
  DormitoryType dormitoryType,
) async {
  List<MealData?> weeklyMeals = [];

  try {
    for (int i = 0; i < 7; i++) {
      DateTime date = now.add(Duration(days: i));
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      MealData? mealData;

      List<Map<String, dynamic>> results;

      if (dormitoryType == DormitoryType.sejong) {
        // 기숙사 타입이 세종인 경우 세종기숙사 데이터를 가져옵니다.
        final sejongBreakFast = await fetchSejongMeal(9);
        final sejongLunch = await fetchSejongMeal(18);
        final sejongDinner = await fetchSejongMeal(26);

        for (int i = 0; i < 7; i++) {
          mealData = MealData(
            breakfast: sejongBreakFast[i],
            lunch: sejongLunch[i],
            dinner: sejongDinner[i],
          );
          weeklyMeals.add(mealData); // 해당 날짜의 데이터를 리스트에 추가
        }
      } else {
        // 기숙사 타입이 행복인 경우 행복기숙사 데이터를 가져옵니다.
        final happyMeals = await fetchHappyMeals();
      }
    }
    return weeklyMeals;
  } catch (e) {
    throw Exception("없음");
  }
}
