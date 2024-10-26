import 'package:flutter_whattodayrice/data/models/meal.dart';

abstract interface class DormitoryMealRepository {
  Future<List<MealData>> fetchHappyMeals();
}
