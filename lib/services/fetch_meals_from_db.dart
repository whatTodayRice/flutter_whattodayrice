import 'package:flutter_whattodayrice/services/fetch_happy_meals.dart';
import 'package:flutter_whattodayrice/services/fetch_sejong_meal.dart';
import '../models/dormitory.dart';
import '../models/meal.dart';

Future<List<MealData?>> fetchMealDataFromDB(
  DateTime now,
  DormitoryType dormitoryType,
) async {
  List<MealData?> weeklyMeals = [];

  try {
    if (dormitoryType == DormitoryType.sejong) {
      weeklyMeals = await fetchSejongMeals();
    } else {
      // 기숙사 타입이 행복인 경우 행복기숙사 데이터를 가져옵니다.
      weeklyMeals = await fetchHappyMeals();
    }
    return weeklyMeals;
  } catch (e) {
    throw Exception("없음");
  }
}
