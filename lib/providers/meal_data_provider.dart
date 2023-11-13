import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/models/meal.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/providers/dto_user_info.dart';
import 'package:flutter_whattodayrice/services/fetch_meals_from_db.dart';

final mealDataProvider = FutureProvider<List<MealData?>>(
  (ref) async {
    //todo : 여기서 shared preferences에 저장된 기숙사값을 불러오고 fetchMeal

     DormitoryType dormitoryType = ref.watch(dormitoryProvider);
    try {
      final weeklyMeals = await fetchMealDataFromDB(dormitoryType);
      return weeklyMeals;
    } catch (error) {
      print('Error fetching meal data: $error');
      return [];
    }
  },
);
