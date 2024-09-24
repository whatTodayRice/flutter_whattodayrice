import 'package:flutter_whattodayrice/data/services/happy_meal_service.dart';
import 'package:html/dom.dart';

class HappyDormsMealRemoteDataSource {
  late final HappyMealService _happyMealService;

  HappyDormsMealRemoteDataSource._internal(HappyMealService happyMealService) {
    _happyMealService = happyMealService;
  }

  static HappyDormsMealRemoteDataSource? _instance;

  factory HappyDormsMealRemoteDataSource({required HappyMealService happyMealService}) {
    _instance ??= HappyDormsMealRemoteDataSource._internal(happyMealService);

    return _instance!;
  }

  HappyDormsMealRemoteDataSource getInstance() {
    if (_instance == null) {
      throw Exception("HappyDormsMealRemoteDataSource instance를 먼저 초기화해주세요");
    }

    return _instance!;
  }

  Future<Document> fetchHappyMeals() => _happyMealService.fetchHappyMeals();
}
