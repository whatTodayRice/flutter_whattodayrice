import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/services/fetch_meals_from_db.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';
import 'package:intl/intl.dart';
import '../../models/dormitory.dart';
import '../../models/meal.dart';
import '../components/meal_container.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:developer';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  List<MealData?> weeklyMeals = [];
  DormitoryType dormitoryType = DormitoryType.sejong;

  Future<void> fetchMealData() async {
    DateTime now = DateTime.now();
    if (dormitoryType == DormitoryType.sejong) {
      weeklyMeals = await fetchMealDataFromDB(now, DormitoryType.sejong);
    } else {
      weeklyMeals = await fetchMealDataFromDB(now, DormitoryType.happiness);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    fetchMealData();
  }

  DateTime monday = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - 1)); // 월요일부터로 조정

  DateTime sunday = DateTime.now()
      .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday));

  DateTime selectedDate = DateTime.now();

  void onDaySelected(DateTime selectedDay) {
    int selectedDayWeekday = selectedDay.weekday;
    DateTime monday =
        selectedDay.subtract(Duration(days: selectedDayWeekday - 1));

    setState(() {
      selectedDate = selectedDay;
    });

    int differenceInDays = selectedDay.difference(monday).inDays;

    if (differenceInDays >= 0 && differenceInDays < weeklyMeals.length) {
      if (selectedDate != DateTime.now()) {
        _pageController.animateToPage(
          differenceInDays,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        moveToTodayMenu();
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(
                  "그 날짜에 맞는 식단 데이터가 아직 올라오지 않았어요",
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('확인'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // var selectedDormitory = ref.watch(selectedDormitoryProvider);
    //DormitoryType dormitoryType = DormitoryType.happiness;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: DropdownButton<String>(
          value: dormitoryType == DormitoryType.sejong ? "세종기숙사" : "행복기숙사",
          items: const [
            DropdownMenuItem(
              value: "세종기숙사",
              child: Text("세종기숙사"),
            ),
            DropdownMenuItem(
              value: "행복기숙사",
              child: Text("행복기숙사"),
            ),
          ],
          onChanged: (value) {
            setState(() {
              // 사용자가 기숙사 타입을 선택하면 해당 데이터를 다시 가져옵니다.
              if (value == "세종기숙사") {
                dormitoryType = DormitoryType.sejong;
              } else {
                dormitoryType = DormitoryType.happiness;
              }
              fetchMealData();
            });
          },
        ),

        // Text(selectedDormitory == DormitoryType.sejong ? "세종기숙사" : "행복기숙사"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
              fetchMealData();
            },
          ),
        ],
      ), // 기숙사에 따라 Text 내용 수정하기
      body: weeklyMeals.isNotEmpty
          ? SizedBox(
              height: 700,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: weeklyMeals.length,
                itemBuilder: (context, index) {
                  var meal = weeklyMeals[index];
                  DateTime date = DateTime.now().add(
                    Duration(
                      days: index,
                    ),
                  );
                  return buildMealPage(
                    meal,
                    index,
                    screenWidth,
                    screenHeight,
                    moveToTodayMenu,
                    onDaySelected,
                    date,
                    moveToTodayMenu,
                    moveToPreviousPage,
                    moveToNextPage,
                    dormitoryType,
                  );
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(), // 데이터를 가져오는 동안 로딩 표시
            ),
    );
  }

  void moveToTodayMenu() {
    DateTime userAccessDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(userAccessDate);

    // weeklyMeals 리스트를 순회하며 userAccessDate와 일치하는 식단을 찾습니다.
    int todayMenuIndex = -1;
    for (int i = 0; i < weeklyMeals.length; i++) {
      MealData? meal = weeklyMeals[i];
      if (meal?.date == formattedDate) {
        todayMenuIndex = i;
        break;
      }
    }

    if (todayMenuIndex != -1) {
      // PageView를 해당 인덱스로 이동시킵니다.
      _pageController.animateToPage(
        todayMenuIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // userAccessDate와 일치하는 식단이 없는 경우에 대한 처리
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('오늘의 식단이 없습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  void moveToNextPage() {
    final currentPage = _pageController.page ?? 0;
    final nextPage = currentPage + 1;
    if (nextPage < weeklyMeals.length) {
      _pageController.animateToPage(
        nextPage.toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void moveToPreviousPage() {
    final currentPage = _pageController.page ?? 0;
    final previousPage = currentPage - 1;
    if (previousPage >= 0) {
      _pageController.animateToPage(
        previousPage.toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }
}

Widget buildMealPage(
  MealData? meal,
  int index,
  double screenWidth,
  double screenHeight,
  void Function() moveToTodayMenu,
  void Function(DateTime selectedDay) onDaySelected,
  DateTime date,
  VoidCallback onPressedToday,
  VoidCallback onPressedBack,
  VoidCallback onPressedForward,
  DormitoryType dormitoryType,
) {
  DateTime currentDate = DateTime.now();
  DateTime date = DateTime.now().add(Duration(days: index));
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);

  if (meal != null) {
    return Column(
      children: [
        CalenderRow(
          width: screenWidth,
          height: screenHeight,
          onDateSelected: onDaySelected,
          date: date,
          onPressedBack: onPressedBack,
          onPressedForward: onPressedForward,
          onPressedToday: onPressedToday,
        ),
        SizedBox(
          height: screenHeight * 0.039,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: MealTimeTextRow(
              mealTime: getBreakfastTimeText(
                dormitoryType,
                currentDate,
              ),
              mealType: breakfast,
              width: screenWidth,
              height: screenHeight),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildContainer(
            content: '아침: ${meal.breakfast}',
            height: screenHeight,
            width: screenWidth,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: MealTimeTextRow(
              mealTime: getLunchTimeText(
                dormitoryType,
                currentDate,
              ),
              mealType: lunch,
              width: screenWidth,
              height: screenHeight),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildContainer(
            content: '점심: ${meal.lunch}',
            height: screenHeight,
            width: screenWidth,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: MealTimeTextRow(
              mealTime: getDinnerTimeText(
                dormitoryType,
                currentDate,
              ),
              mealType: dinner,
              width: screenWidth,
              height: screenHeight),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildContainer(
            content: '저녁: ${meal.dinner}',
            height: screenHeight,
            width: screenWidth,
          ),
        ),
      ],
    );
  } else {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Date: $formattedDate\nNo meal data available.',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

String getBreakfastTimeText(DormitoryType dormitoryType, DateTime currentDate) {
  if (dormitoryType == DormitoryType.sejong) {
    if (currentDate.isAfter(DateTime(2023, 6, 27)) &&
        currentDate.isBefore(DateTime(2023, 8, 31))) {
      log(sejongVacationBreakfastTime);
      return sejongVacationBreakfastTime;
    } else {
      log(sejongBreakfastTime);
      return sejongBreakfastTime;
    }
  } else {
    if (isWeekday(currentDate)) {
      log(happyBreakfastWeekTime);
      return happyBreakfastWeekTime;
    } else {
      log(happyBreakfastTime);
      return happyBreakfastTime;
    }
  }
}

String getLunchTimeText(DormitoryType dormitoryType, DateTime currentDate) {
  if (dormitoryType == DormitoryType.sejong) {
    if (currentDate.isAfter(DateTime(2023, 6, 27)) &&
        currentDate.isBefore(DateTime(2023, 8, 31))) {
      log(sejongVacationLunchTime);
      return sejongVacationLunchTime;
    } else {
      log(sejongLunchTime);
      return sejongLunchTime;
    }
  } else {
    if (isWeekday(currentDate)) {
      log(happyLunchWeekTime);
      return happyLunchWeekTime;
    } else {
      log(happyLunchTime);
      return happyLunchTime;
    }
  }
}

String getDinnerTimeText(DormitoryType dormitoryType, DateTime currentDate) {
  if (dormitoryType == DormitoryType.sejong) {
    if (currentDate.isAfter(DateTime(2023, 6, 27)) &&
        currentDate.isBefore(DateTime(2023, 8, 31))) {
      log(sejongVacaitonDinnerTime);
      return sejongVacaitonDinnerTime;
    } else {
      log(sejongDinnerTime);
      return sejongDinnerTime;
    }
  } else {
    if (isWeekday(currentDate)) {
      log(happyDinnerWeekTime);
      return happyDinnerWeekTime;
    } else {
      log(happyDinnerTime);
      return happyDinnerTime;
    }
  }
}

bool isWeekday(DateTime date) {
  return date.weekday >= DateTime.monday && date.weekday <= DateTime.friday;
}
