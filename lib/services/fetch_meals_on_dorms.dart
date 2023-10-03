import 'package:flutter_whattodayrice/services/fetch_happy_meals.dart';
import 'package:flutter_whattodayrice/services/fetch_sejong_meals.dart';
import 'package:intl/intl.dart';
import '../models/dormitory.dart';
import '../models/meal.dart';

Future<List<MealData>> fetchMealDataDependingOnDorms(
  DormitoryType dormitoryType,
) async {
  List<MealData> weeklyMeals = [];

  try {
    if (dormitoryType == DormitoryType.sejong) {
      // 기숙사 타입이 세종인 경우 세종기숙사 데이터를 가져옵니다.
      weeklyMeals = await fetchSejongMeals();
    } else {
      // 기숙사 타입이 행복인 경우 행복기숙사 데이터를 가져옵니다.
      weeklyMeals = await fetchHappyMeals();
    }
    return weeklyMeals;
  } catch (e) {
    print(e);
    throw Exception("없음");
  }
}
