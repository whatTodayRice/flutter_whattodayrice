import 'package:flutter_whattodayrice/common/utils/home_widget/happy_widget.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import '../data_source/happy_meal_data_source.dart';

class DormitoryMealRepository {
  late final HappyDormsMealRemoteDataSource _happyDormsMealRemoteDataSource;

  DormitoryMealRepository._internal(HappyDormsMealRemoteDataSource happyDormsMealRemoteDataSource) {
    _happyDormsMealRemoteDataSource = happyDormsMealRemoteDataSource;
  }

  static DormitoryMealRepository? _instance;

  factory DormitoryMealRepository({required HappyDormsMealRemoteDataSource happyDormsMealRemoteDataSource}) {
    _instance ??= DormitoryMealRepository._internal(happyDormsMealRemoteDataSource);

    return _instance!;
  }

  DormitoryMealRepository getInstance() {
    if (_instance == null) {
      throw Exception("DormitoryMealRepository instance를 먼저 초기화해주세요");
    }

    return _instance!;
  }

  Future<List<MealData>> fetchHappyMeals() async {
    final happyMealResponse = await _happyDormsMealRemoteDataSource.fetchHappyMeals();

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
      String breakfast = menuElements[startIndex]
          .text
          .splitMapJoin(RegExp(r'\s+'), onMatch: (match) => ' ', onNonMatch: (nonMatch) => nonMatch);
      String takeout = menuElements[startIndex + 2]
          .text
          .splitMapJoin(RegExp(r'\s+'), onMatch: (match) => ' ', onNonMatch: (nonMatch) => nonMatch);

      // lunch와 dinner 변수에 들어가는 데이터에서 "일품" 앞에 들여쓰기 추가
      String lunch =
          menuElements[startIndex + 5].text.replaceAllMapped(RegExp(r'(일품 : .+)'), (match) => '\n\n${match[1]}').trim();
      String dinner =
          menuElements[endIndex].text.replaceAllMapped(RegExp(r'(일품 : .+)'), (match) => '\n\n${match[1]}').trim();

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
}
