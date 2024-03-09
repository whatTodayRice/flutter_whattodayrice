import 'package:flutter_whattodayrice/providers/dto_user_info.dart';
import 'package:flutter_whattodayrice/services/fetch_happy_meals.dart';
import 'package:flutter_whattodayrice/services/fetch_sejong_meals.dart';
import '../models/dormitory.dart';
import '../models/meal.dart';

Future<List<MealData?>> fetchMealDataFromDB(DormitoryType dormitoryType) async {
  List<MealData?> weeklyMeals = [];

  final dormitory = await readDormitorySharedPreferencesData();

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
  } catch (e) {
    throw Exception("없음");
  }
}
