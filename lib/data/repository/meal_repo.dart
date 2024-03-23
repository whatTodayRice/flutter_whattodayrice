import 'package:flutter_whattodayrice/common/utils/converter/remove_meal_comma.dart';
import 'package:flutter_whattodayrice/common/utils/home_widget/happy_widget.dart';
import 'package:flutter_whattodayrice/common/utils/home_widget/sejong_widget.dart';
import 'package:flutter_whattodayrice/common/utils/sejong_parse_date_string.dart';
import 'package:flutter_whattodayrice/data/data_source/sejong_meal.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:intl/intl.dart';
import '../data_source/happy_meal_data_source.dart';

class DormitoryMealRepository {
  final HappyDormsMealRemoteDataSource _happyDormsMealRemoteDataSource;
  final SejongDormsMealRemoteDataSource _sejongMealRemoteDataSource;

  DormitoryMealRepository(
      this._happyDormsMealRemoteDataSource, this._sejongMealRemoteDataSource);

  Future<List<MealData>> fetchHappyMeals() async {
    var happyMealResponse =
        await _happyDormsMealRemoteDataSource.fetchHappyMeals();

    var dateElements = happyMealResponse.querySelectorAll('th[colspan="3"]');
    var menuElements = happyMealResponse.querySelectorAll('.meal__PC');
    var weeklyDate = dateElements.sublist(0, 73);

    List<MealData> menus = [];

    for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
      int startIndex = 2 + dayIndex * 19; // 해당 요일의 시작 인덱스
      int endIndex = 14 + dayIndex * 19; // 해당 요일의 끝 인덱스
      int dateIndex = dayIndex * 12;

      // 정규식을 사용하여 날짜 부분을 추출하고 괄호 제거
      String rawDateString = weeklyDate[dateIndex].text;
      String formattedDate = rawDateString.replaceAll(RegExp(r'[()]'), '');
      formattedDate = formattedDate.split(' ').last; // 날짜 부분 추출

      // 각 식단 항목을 쉼표와 공백으로 구분하여 저장
      String breakfast = menuElements[startIndex].text.splitMapJoin(
          RegExp(r'\s+'),
          onMatch: (match) => ' ',
          onNonMatch: (nonMatch) => nonMatch);
      String takeout = menuElements[startIndex + 2].text.splitMapJoin(
          RegExp(r'\s+'),
          onMatch: (match) => ' ',
          onNonMatch: (nonMatch) => nonMatch);

      // lunch와 dinner 변수에 들어가는 데이터에서 "일품" 앞에 들여쓰기 추가
      String lunch = menuElements[startIndex + 5]
          .text
          .replaceAllMapped(RegExp(r'(일품 : .+)'), (match) => '\n\n${match[1]}')
          .trim();
      String dinner = menuElements[endIndex]
          .text
          .replaceAllMapped(RegExp(r'(일품 : .+)'), (match) => '\n\n${match[1]}')
          .trim();

      MealData menu = MealData(
        date: formattedDate,
        breakfast: breakfast,
        takeout: takeout,
        lunch: lunch,
        dinner: dinner,
      );

      menus.add(menu);
      updateMeal(menu);
    }
    return menus;
  }

  Future<List<MealData>> fetchSejongMeals() async {
    List<MealData> menus = [];

    List<String> dateData =
        await _sejongMealRemoteDataSource.fetchSejongMeals(0);
    List<String> dateValues = dateData[7].split(','); // 요일과 날짜를 쉼표로 분리

    int breakfastIndex = 9;
    List<String> breakfastData =
        await _sejongMealRemoteDataSource.fetchSejongMeals(breakfastIndex);
    breakfastData.removeAt(0);
    List<String> removedCommabreakfastData =
        removeCommaEachMeal(meals: breakfastData);

    int lunchIndex = 19;
    List<String> lunchData =
        await _sejongMealRemoteDataSource.fetchSejongMeals(lunchIndex);
    lunchData.removeLast();
    List<String> removedCommaLunchData = removeCommaEachMeal(meals: lunchData);

    int dinnerIndex = 27;
    List<String> dinnerData =
        await _sejongMealRemoteDataSource.fetchSejongMeals(dinnerIndex);
    dinnerData.removeAt(0);
    List<String> removedCommaDinnerData =
        removeCommaEachMeal(meals: dinnerData);

    for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
      String fetchedDate = dateValues[dayIndex + 2].trim();
      DateTime convertedFetchedDate = parseDateString(fetchedDate);
      String formattedString =
          DateFormat('yyyy-MM-dd', 'ko_KR').format(convertedFetchedDate);

      MealData menu = MealData(
          date: formattedString,
          breakfast: removedCommabreakfastData[dayIndex],
          takeout: '',
          lunch: removedCommaLunchData[dayIndex],
          dinner: removedCommaDinnerData[dayIndex]);
      menus.add(menu);
      updateFullMeal(menu);
    }

    return menus;
  }
}
