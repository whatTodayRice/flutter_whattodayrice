import 'dart:convert';
import 'dart:io';
import 'package:html/parser.dart';
import 'package:flutter_whattodayrice/models/meal.dart';
import 'dart:async';

import 'package:intl/intl.dart';

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

  //TODO 기준 날짜를 저번주 일요일로 하면 되는 거 아닌가?
  DateTime sunday = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day - (DateTime.now().weekday - 1))
      .subtract(const Duration(days: 1));

  //각 식단별 인덱스 값
  int breakfastIndex = 9;
  int lunchIndex = 19;
  int dinnerIndex = 27;

  //데이터 패치 & 가공
  List<String> breakfastData = await fetchMeal(breakfastIndex);
  breakfastData.removeAt(0);

  //날짜 데이터
  List<String> dateData=await fetchMeal(0);
  List<String> date = dateData[7].split(',').sublist(2,9);

  int currentYear = DateTime.now().year;

  // 월, 일 정보를 추출하고 날짜 문자열로 변환
  List<String> convertedDates = date.map((date) {
  // 월과 일 정보 추출
  String month = date.split('(')[1].split('/')[0];
  String day = date.split('/')[1].split(')')[0];

  // 날짜 문자열 생성
  String formattedDate = '$currentYear-${month.padLeft(2,'0')}-${day.padLeft(2, '0')}';

  return formattedDate;
  }).toList();


  List<String> lunchData = await fetchMeal(lunchIndex);
  lunchData.removeLast();

  List<String> dinnerData = await fetchMeal(dinnerIndex);
  dinnerData.removeLast();



  //mealData에 넣어주기
  for (int dayIndex = 0; dayIndex < 7; dayIndex++) {

    // DateTime dateAddFromToday  = sunday.add(Duration(days: dayIndex));
    // // String formattedDate = DateFormat('yyyy-MM-dd').format(dateAddFromToday);
    MealData menu = MealData(
        date: convertedDates[dayIndex],
        breakfast: breakfastData[dayIndex],
        takeout: '',
        lunch: lunchData[dayIndex],
        dinner: dinnerData[dayIndex]);
    menus.add(menu);

  }


  return menus;
}
