import 'package:flutter_whattodayrice/models/happy_meal.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

Future<List<HappyMealData>> fetchHappyMeals() async {
  final response = await http
      .get(Uri.parse('https://happydorm.or.kr/busan/ko/0606/cafeteria/menu/'));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    var menuElements = document.querySelectorAll('.meal__PC');

    List<HappyMealData> menus = [];

    for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
      int startIndex = 2 + dayIndex * 19; // 해당 요일의 시작 인덱스
      int endIndex = 14 + dayIndex * 19; // 해당 요일의 끝 인덱스

      HappyMealData menu = HappyMealData(
        breakfast: menuElements[startIndex].text,
        takeout: menuElements[startIndex + 2].text,
        lunch: menuElements[startIndex + 5].text,
        dinner: menuElements[endIndex].text,
      );

      menus.add(menu);
    }

    return menus;
  } else {
    throw Exception('식단을 받아오지 못했어요ㅠ_ㅠ');
  }
}
