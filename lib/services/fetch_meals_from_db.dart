import 'package:flutter_whattodayrice/services/fetch_happy_meals.dart';
import 'package:flutter_whattodayrice/services/fetch_sejong_meals.dart';
import '../models/dormitory.dart';
import '../models/meal.dart';

Future<List<MealData?>> fetchMealDataFromDB(
  DormitoryType dormitoryType,
) async {
  List<MealData?> weeklyMeals = [];

  try {
    if (dormitoryType == DormitoryType.sejong1 ||
        dormitoryType == DormitoryType.sejong2) {
      weeklyMeals = await fetchSejongMeals();
    } else {
      weeklyMeals = await fetchHappyMeals();
    }
    return weeklyMeals;
  } catch (e) {
    print(e);
    throw Exception("없음");
  }
}
