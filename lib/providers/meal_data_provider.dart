import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/meal.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/services/fetch_meals_from_db.dart';

final mealDataProvider = FutureProvider<List<MealData?>>(
  (ref) async {
    final dormitoryType = ref.watch(dormitoryProvider);

    try {
      final weeklyMeals = await fetchMealDataFromDB(dormitoryType);
      return weeklyMeals;
    } catch (error) {
      print('Error fetching meal data: $error');
      return [];
    }
  },
);
