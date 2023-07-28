import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';
import 'package:intl/intl.dart';

import '../../models/happy_meal.dart';
import '../components/meal_container.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  List<HappyMealData?> weeklyMeals = [];
  HomeScreen(this.weeklyMeals, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

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

    if (differenceInDays >= 0 && differenceInDays < widget.weeklyMeals.length) {
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
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('세종기숙사'), // 기숙사에 따라 Text 내용 수정하기
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // TableCalendar(
          //   daysOfWeekStyle: const DaysOfWeekStyle(
          //     weekdayStyle: TextStyle(fontSize: 10.0),
          //     weekendStyle: TextStyle(fontSize: 10.0),
          //   ),
          //   calendarStyle: const CalendarStyle(
          //     outsideDaysVisible: true,
          //     weekendTextStyle: TextStyle(fontSize: 10.0),
          //     defaultTextStyle: TextStyle(
          //       fontSize: 10.0,
          //     ),
          //     todayTextStyle: TextStyle(
          //       fontSize: 10.0,
          //     ),
          //     selectedTextStyle: TextStyle(
          //       fontSize: 10.0,
          //     ), // Adjust the font size for the selected date
          //   ),
          //   onDaySelected: (selectedDate, focusDay) {
          //     onDaySelected(selectedDate, focusDay);
          //   },
          //   focusedDay: DateTime.now(),
          //   firstDay: monday,
          //   lastDay: DateTime(2023, 7, 31),
          //   headerVisible: false,
          //   calendarFormat: CalendarFormat.week,
          //   locale: 'ko_KR',
          // ),
          SizedBox(
            height: 700, // Constrain the height of the PageView
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.weeklyMeals.length,
              itemBuilder: (context, index) {
                HappyMealData? meal = widget.weeklyMeals[index];
                DateTime date = DateTime.now().add(
                    Duration(days: index)); // Get the date for the current page

                return buildMealPage(meal, index, screenWidth, screenHeight,
                    moveToTodayMenu, onDaySelected, date);
              },
            ),
          ),
        ],
      ),
    );
  }

  void moveToTodayMenu() {
    DateTime userAccessDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(userAccessDate);

    // weeklyMeals 리스트를 순회하며 userAccessDate와 일치하는 식단을 찾습니다.
    int todayMenuIndex = -1;
    for (int i = 0; i < widget.weeklyMeals.length; i++) {
      HappyMealData? meal = widget.weeklyMeals[i];
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
}

Widget buildMealPage(
  HappyMealData? meal,
  int index,
  double screenWidth,
  double screenHeight,
  void Function() moveToTodayMenu,
  void Function(DateTime selectedDay) onDaySelected,
  DateTime date,
) {
  DateTime date = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - 1))
      .add(Duration(days: index));
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);

  if (meal != null) {
    return Column(
      children: [
        CalenderRow(
          width: screenWidth,
          height: screenHeight,
          onPressed: moveToTodayMenu,
          onDateSelected: onDaySelected,
          date: date,
        ),
        SizedBox(
          height: screenHeight * 0.039,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: MealTimeTextRow(
              mealTime: breakfastTime,
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
              mealTime: lunchTime,
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
              mealTime: dinnerTime,
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
