import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../models/meal.dart';

Future<List<String>> fetchMeal(int menuIndex) async {
  final response = await http.post(
      Uri.parse('https://dormitory.pknu.ac.kr/03_notice/req_getSchedule.php'));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    print(document);
    var targetElement = document.getElementsByClassName('board_box').first;
    String data = targetElement.text.replaceAll('\t', '');

    String data2 = data.replaceAll('\n', ',');
    List<String> mealData = data2.split(',');
    var SejongmealData = data2.split(',,').sublist(menuIndex, menuIndex + 8);


    return SejongmealData;
  } else {
    throw Exception('식단을 기다리고 있어요 조금만 기다려주세요😀 ');
  }
}


Future<List<MealData?>> fetchMealData() async {
  List<MealData> menus = [];
  for (int dayIndex = 0;dayIndex<7;dayIndex++) {
    int breakfastIndex =9 + dayIndex;
    int lunchIndex = 18+dayIndex;
    int dinnerIndex = 26 + dayIndex;


    List<String> breakfastData = await fetchMeal(breakfastIndex);
    List<String> lunchData = await fetchMeal(lunchIndex);
    List<String> dinnerData = await fetchMeal(dinnerIndex);

    DateTime currentDate = DateTime.now().add(Duration(days: dayIndex));
    String formattedDate = currentDate.toString();

    MealData menu = MealData(
        date: formattedDate,
        breakfast: breakfastData[dayIndex],
        takeout: '',
        lunch: lunchData[dayIndex],
        dinner:dinnerData[dayIndex]
    );

    menus.add(menu);
  }

  return menus;
}