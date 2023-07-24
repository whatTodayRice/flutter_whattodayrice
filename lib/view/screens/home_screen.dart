import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/view/components/sejong_meal_container.dart';
import 'package:intl/intl.dart';

import '../../models/happy_meal.dart';
import '../../services/sejong_fetch_meal_db.dart';

class HomeScreen extends StatefulWidget {
  List<HappyMealData?> weeklyMeals = [];

  HomeScreen(this.weeklyMeals, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
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
            return buildMealCard(meal, index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveToTodayMenu, // "오늘의 식단" 버튼 클릭 시 moveToTodayMenu 함수 호출
        child: const Text('오늘의\n식단'),
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

Widget buildMealCard(HappyMealData? meal, int index) {
  DateTime date = DateTime.now().add(Duration(days: index));
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);

  if (meal != null) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Date: $formattedDate',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Breakfast: ${meal.breakfast}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Lunch: ${meal.lunch}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Dinner: ${meal.dinner}'),
          ),
        ],
      ),
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

// class MainFragMent extends StatelessWidget {
//   const MainFragMent({
//     super.key,
//     required this.width,
//     required this.height,
//   });
//
//   final double width;
//   final double height;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         CalenderRow(
//           width: width,
//           height: height,
//         ),
//         SizedBox(
//           height: height * 0.039,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: MealTimeTextRow(
//               mealTime: breakfastTime,
//               mealType: breakfast,
//               width: width,
//               height: height),
//         ),
//         SizedBox(
//           height: height * 0.026,
//         ),
//         SejongBreakfastContainer(height: height, width: width),
//         SizedBox(
//           height: height * 0.1,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: MealTimeTextRow(
//               mealTime: lunchTime,
//               mealType: lunch,
//               width: width,
//               height: height),
//         ),
//         SizedBox(
//           height: height * 0.026,
//         ),
//         SejongLunchContainer(height: height, width: width),
//         SizedBox(
//           height: height * 0.1,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: MealTimeTextRow(
//               mealTime: dinnerTime,
//               mealType: dinner,
//               width: width,
//               height: height),
//         ),
//         SizedBox(
//           height: height * 0.026,
//         ),
//         SejongDinnerContainer(height: height, width: width),
//       ],
//     );
//   }
// }
