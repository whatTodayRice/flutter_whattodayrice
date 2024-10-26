import 'package:flutter_whattodayrice/data/data_sources/remote/services/happy_meal_service.dart';
import 'package:html/dom.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class HappyDormsMealRemoteDataSource {
  final HappyMealService happyMealService;

  const HappyDormsMealRemoteDataSource({required this.happyMealService});

  Future<Document?> fetchHappyMeals() => happyMealService.fetchHappyMeals();
}
