// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_whattodayrice/models/meal.dart';
// import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
// import 'package:flutter_whattodayrice/services/fetch_meals_from_db.dart';
//
// final mealsProvider = FutureProvider<List<MealData?>>((ref) async {
//   final now = DateTime.now();
//   final dormitoryType = ref.watch(selectedDormitoryProvider);
//
//   final meals = await fetchMealDataFromDB(now, dormitoryType);
//
//   return meals;
// });
//
// class MealsNotifier extends StateNotifier<List<MealData?>> {
//   MealsNotifier() : super([]);
// }
