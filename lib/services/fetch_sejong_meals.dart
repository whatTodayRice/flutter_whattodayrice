import 'dart:convert';
import 'dart:io';
import 'package:home_widget/home_widget.dart';
import 'package:html/parser.dart';
import 'package:flutter_whattodayrice/models/meal.dart';
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
    throw Exception('식단을 기다리고 있어요. 조금만 기다려주세요:grinning: ');
  }
}

Future<List<MealData>> fetchSejongMeals() async {
  List<MealData> menus = [];

  List<String> dateData = await fetchMeal(0);
  List<String> dateValues = dateData[7].split(','); // 요일과 날짜를 쉼표로 분리

  int breakfastIndex = 9;
  List<String> breakfastData = await fetchMeal(breakfastIndex);
  breakfastData.removeAt(0);

  int lunchIndex = 19;
  List<String> lunchData = await fetchMeal(lunchIndex);
  lunchData.removeLast();

  int dinnerIndex = 27;
  List<String> dinnerData = await fetchMeal(dinnerIndex);
  dinnerData.removeLast();

  for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
    String fetchedDate = dateValues[dayIndex + 2].trim();
    DateTime convertedFetchedDate = parseDateString(fetchedDate);
    String formattedString =
        DateFormat('yyyy-MM-dd', 'ko_KR').format(convertedFetchedDate);

    MealData menu = MealData(
        date: formattedString,
        breakfast: breakfastData[dayIndex],
        takeout: '',
        lunch: lunchData[dayIndex],
        dinner: dinnerData[dayIndex]);
    menus.add(menu);
    updateFullMeal(menu);
  }
  return menus;
}

DateTime parseDateString(String formattedDate) {
  // 정규 표현식을 사용하여 월과 일 추출
  final RegExp regex = RegExp(r'(\d{1,2})/(\d{1,2})');
  final Match match = regex.firstMatch(formattedDate)!;

  // 정규 표현식에서 그룹 1은 월, 그룹 2는 일을 나타냅니다.
  final int month = int.parse(match.group(1)!);
  final int day = int.parse(match.group(2)!);

  // 현재 연도 가져오기
  int currentYear = DateTime.now().year;

  // DateTime 객체 생성
  DateTime dateTime = DateTime(currentYear, month, day);
  return dateTime;
}

const String androidFullMealsWidgetName = 'FullMealsWidget';
const String androidMealWidgetName = 'MealWidget';

void updateFullMeal(MealData sejongMeal) {
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final tomorrow = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(const Duration(days: 1)));

  var hour = DateTime.now().hour;
  var minute = DateTime.now().minute;

  String targetDate = today;

  if ((hour > 18 || (hour == 18 && minute >= 30)) ||
      (hour < 7 || hour == 7 && minute <= 30)) {
    targetDate = tomorrow;
  }
  if (sejongMeal.date == targetDate) {
    updateSejongFullWidgetDate(sejongMeal);
  }

  HomeWidget.updateWidget(androidName: androidFullMealsWidgetName);
  HomeWidget.updateWidget(androidName: androidMealWidgetName);
}

void updateSejongFullWidgetDate(MealData sejongMeal) {
  HomeWidget.saveWidgetData("sejong_date", sejongMeal.date);
  HomeWidget.saveWidgetData<String>('sejong_breakfast', sejongMeal.breakfast);
  HomeWidget.saveWidgetData<String>('sejong_lunch', sejongMeal.lunch);
  HomeWidget.saveWidgetData<String>('sejong_dinner', sejongMeal.dinner);
}
