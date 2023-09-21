import 'package:flutter_whattodayrice/models/meal.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

Future<List<MealData>> fetchHappyMeals() async {
  final response = await http
      .get(Uri.parse('https://happydorm.or.kr/busan/ko/0606/cafeteria/menu/'));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    var dateElements = document.querySelectorAll('th[colspan="3"]');
    var menuElements = document.querySelectorAll('.meal__PC');

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
      print(formattedDate);

      MealData menu = MealData(
        date: formattedDate,
        breakfast: menuElements[startIndex].text,
        takeout: menuElements[startIndex + 2].text,
        lunch: menuElements[startIndex + 5].text,
        dinner: menuElements[endIndex].text,
      );
      print(menu);
      menus.add(menu);
    }

    return menus;
  } else {
    throw Exception('식단을 받아오지 못했어요ㅠ_ㅠ');
  }
}
