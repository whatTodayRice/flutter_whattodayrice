import 'package:flutter_whattodayrice/data/services/happy_meal_service.dart';
import 'package:html/dom.dart';

class HappyDormsMealRemoteDataSource {
  final HappyMealService _happyMealService;

  HappyDormsMealRemoteDataSource(this._happyMealService);

  Future<Document> fetchHappyMeals() async {
    return await _happyMealService.fetchHappyMeals();
  }
}
