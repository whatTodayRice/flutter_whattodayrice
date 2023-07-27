import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:intl/intl.dart';

import '../../models/happy_meal.dart';
import '../components/meal_container.dart';

class HomeScreen extends StatefulWidget {
  List<HappyMealData?> weeklyMeals = [];
  HomeScreen(this.weeklyMeals, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);

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
              // Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: SizedBox(
        height: 700, // Constrain the height of the PageView
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.weeklyMeals.length,
          itemBuilder: (context, index) {
            HappyMealData? meal = widget.weeklyMeals[index];
            return buildMealPage(meal, index, screenWidth, screenHeight,
                moveToTodayMenu, moveToPreviousPage, moveToNextPage);
          },
        ),
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

  void moveToNextPage() {
    final currentPage = _pageController.page ?? 0;
    final nextPage = currentPage + 1;
    if (nextPage < widget.weeklyMeals.length) {
      _pageController.animateToPage(
        nextPage.toInt(),
        duration: Duration(milliseconds: 500),
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
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }
}

Widget buildMealPage(
    HappyMealData? meal,
    int index,
    double screenWidth,
    double screenHeight,
    VoidCallback onPressedToday,
    VoidCallback onPressedBack,
    VoidCallback onPressedForward) {
  DateTime date = DateTime.now().add(Duration(days: index));
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);

  if (meal != null) {
    return Column(
      children: [
        CalenderRow(
          width: screenWidth,
          height: screenHeight,
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
