import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/models/meal.dart';

import 'fetch_meals_from_db.dart';

Future<List<MealData?>> fetchMealDataFile(DormitoryType dormitoryType) async {
  DateTime now = DateTime.now();
  List<MealData?> weeklyMeals = [];

  try {
    weeklyMeals = await fetchMealDataFromDB(now, dormitoryType);
    print('fetchMealDataFile 눌림');
  } catch (error) {
    print('Error fetching meal data : $error');
  }

  return weeklyMeals;
}
