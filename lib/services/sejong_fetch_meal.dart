import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/theme/text_styles.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<List<String>> fetchMeal(int menuIndex) async {
  final response = await http.get(
      Uri.parse('https://dormitory.pknu.ac.kr/03_notice/req_getSchedule.php'));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    var targetElement = document.getElementsByClassName('board_box').first;
    String data = targetElement.text.replaceAll('\t', '');

    String data2 = data.replaceAll('\n', ',');

    List<String> mealTime = data2.split(',,').sublist(menuIndex, menuIndex + 8);

    return mealTime;
  } else {
    throw Exception('식단을 기다리고 있어요 조금만 기다려주세요😀 ');
  }
}

Widget buildDayMealWidget(List<String> mealData, int weekIndex) {
  return FetchDayMeal(meal: mealData[weekIndex]);
} //요일별로 식단 가져오기 1이면 월요일 7일면 일요일

class FetchDayMeal extends StatelessWidget {
  const FetchDayMeal({
    super.key,
    required this.meal,
  });

  final String? meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: double.infinity,
          child: Text(meal!, style: TextStyles.body02),
        ),
      ],
    );
  }
}

class FetchMealSizedBox extends StatelessWidget {
  const FetchMealSizedBox({
    super.key,
    required this.meal,
  });

  final String meal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: Text(
        meal,
        style: TextStyles.body02,
      ),
    );
  }
}

FutureBuilder<List<String>> fetchSejongBreakFast(int weeKIndex) {
  return FutureBuilder(
    future: fetchMeal(9), //월요일 아침 데이터 가져오기
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final meal = snapshot.data![weeKIndex]; //월요일 아침
        return Column(
          children: [
            FetchMealSizedBox(meal: meal),
          ],
        );
      } else {
        throw Error();
      }
    },
  );
}

FutureBuilder<List<String>> fetchSejongLunch(int weekIndex) {
  return FutureBuilder(
    future: fetchMeal(18), //점심 데이터 가져오기
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final meal = snapshot.data![weekIndex]; //각 요일별 점심을 가져오기
        return Column(
          children: [
            FetchMealSizedBox(meal: meal),
          ],
        );
      } else {
        throw Error();
      }
    },
  );
}

FutureBuilder<List<String>> fetchSejongDinner(int weekIndex) {
  print(weekIndex);

  return FutureBuilder(
    future: fetchMeal(26),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final meal = snapshot.data![weekIndex]; //각 요일별 저녁을 가져오기
        return Column(
          children: [
            FetchMealSizedBox(meal: meal),
          ],
        );
      } else {
        throw Error();
      }
    },
  );
}
