import 'dart:convert';
import 'dart:io';
import 'package:html/parser.dart';
import 'package:flutter_whattodayrice/models/meal.dart';
import 'dart:async';

Future<List<String>> fetchMeal(int menuIndex) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  final HttpClientRequest request = await httpClient.getUrl(
      Uri.parse('https://dormitory.pknu.ac.kr/03_notice/req_getSchedule.php'));
  final HttpClientResponse response = await request.close();

  if (response.statusCode == 200) {
    var document = parse(await response.transform(const Utf8Decoder()).join());
    var targetElement = document.getElementsByClassName('board_box').first;
    String data = targetElement.text.replaceAll('\t', '');
    String data2 = data.replaceAll('\n', ',');
    List<String> mealTime = data2.split(',,').sublist(menuIndex, menuIndex + 8);
    return mealTime;
  } else {
    throw Exception('식단을 기다리고 있어요 조금만 기다려주세요:활짝_웃는: ');
  }
}

Future<List<MealData?>> fetchSejongMeals() async {
  List<MealData> menus = [];
  DateTime currentDate = DateTime.now();
  currentDate = currentDate.subtract(Duration(days: currentDate.weekday));
  print('currentDate : $currentDate');
  
  //각 식단별 인덱스 값
  int breakfastIndex = 9;
  int lunchIndex = 19;
  int dinnerIndex = 27;
  
  //데이터 패치 & 가공
  List<String> breakfastData = await fetchMeal(breakfastIndex);
  breakfastData.removeAt(0);
  
  List<String> lunchData = await fetchMeal(lunchIndex);
  lunchData.removeLast();
  
  List<String> dinnerData = await fetchMeal(dinnerIndex);
  dinnerData.removeLast();
  
  //mealData에 넣어주기
  for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
    String formattedDate = currentDate.add(Duration(days: dayIndex)).toString();
    MealData menu = MealData(
        date: formattedDate,
        breakfast: breakfastData[dayIndex],
        takeout: '',
        lunch: lunchData[dayIndex],
        dinner: dinnerData[dayIndex]);
    menus.add(menu);
  }
  return menus;
}
