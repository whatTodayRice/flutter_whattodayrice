import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_whattodayrice/model/meal_model.dart';
import 'package:flutter_whattodayrice/services/sejong_fetch_meal.dart';

class SejongFetchMeal extends StatefulWidget {
  const SejongFetchMeal({super.key});

  @override
  State<SejongFetchMeal> createState() => _SejongFetchMealState();
}

class _SejongFetchMealState extends State<SejongFetchMeal> {
  late Future<Meal> futureMeal;

  Future<List<String>> fetchMeal(int menuIndex) async {
    final response = await http.get(Uri.parse(
        'https://dormitory.pknu.ac.kr/03_notice/req_getSchedule.php'));

    if (response.statusCode == 200) {
      var document = parse(response.body);
      var targetElement = document.getElementsByClassName('board_box').first;
      String data = targetElement.text.replaceAll('\t', '');

      String data2 = data.replaceAll('\n', ',');

      List<String> mealTime =
          data2.split(',,').sublist(menuIndex, menuIndex + 8);

      return mealTime;
    } else {
      throw Exception('조금만 기다려주세요');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        fetchSejongBreakFast(1),
        fetchSejongLunch(1),
        fetchSejongDinner(1),
      ],
    );
  }
}
