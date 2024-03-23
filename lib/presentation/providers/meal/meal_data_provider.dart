import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/data/data_source/happy_meal_data_source.dart';
import 'package:flutter_whattodayrice/data/data_source/sejong_meal.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/data/repository/meal_repo.dart';
import 'package:flutter_whattodayrice/data/services/happy_meal_service.dart';
import 'package:flutter_whattodayrice/data/services/sejong_meal_service.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/presentation/providers/user_provider.dart';

class DormitoryMealViewModel {
  final DormitoryMealRepository _dormitoryMealRepository;

  DormitoryMealViewModel(this._dormitoryMealRepository);

  Future<List<MealData>> fetchMeals(DormitoryType dormitoryType) async {
    if (dormitoryType == DormitoryType.sejong1 ||
        dormitoryType == DormitoryType.sejong2) {
      var sejongWeeklyMeals = await _dormitoryMealRepository.fetchSejongMeals();
      return sejongWeeklyMeals;
    } else {
      var happyWeeklyMeals = await _dormitoryMealRepository.fetchHappyMeals();
      return happyWeeklyMeals;
    }
  }
}

final mealDataProvider = FutureProvider<List<MealData>>(
  (ref) async {
    DormitoryType userDormitoryType =
        ref.watch(userProivder).userUiState.dormitoryType!;
    List<MealData> dormitoryMealViewModel = await DormitoryMealViewModel(
      DormitoryMealRepository(
        HappyDormsMealRemoteDataSource(
          HappyMealService(),
        ),
        SejongDormsMealRemoteDataSource(
          SejongDormMealService(),
        ),
      ),
    ).fetchMeals(userDormitoryType);
    return dormitoryMealViewModel;
  },
);
