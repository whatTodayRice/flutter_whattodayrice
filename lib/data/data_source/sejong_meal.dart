import 'package:flutter_whattodayrice/data/services/sejong_meal_service.dart';

class SejongDormsMealRemoteDataSource {
  final SejongDormMealService _sejongDormMealService;

  SejongDormsMealRemoteDataSource(this._sejongDormMealService);

  Future<List<String>> fetchSejongMeals(int menuIndex) async {
    return await _sejongDormMealService.fetchSejongMeal(menuIndex);
  }
}
