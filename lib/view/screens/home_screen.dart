import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/view/components/sejong_meal_container.dart';
import 'package:intl/intl.dart';

import '../../services/sejong_fetch_meal_db.dart';

class HomeScreen extends StatefulWidget {
  List<MealData?> weeklyMeals = [];

  HomeScreen(this.weeklyMeals, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          scrollDirection: Axis.horizontal,
          itemCount: widget.weeklyMeals.length,
          itemBuilder: (context, index) {
            MealData? meal = widget.weeklyMeals[index];
            return buildMealCard(meal, index);
          },
        ),
      ),
    );
  }
}

Widget buildMealCard(MealData? meal, int index) {
  DateTime date = DateTime.now().add(Duration(days: index));
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);

  if (meal != null) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Date: $formattedDate',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Breakfast: ${meal.breakfast}'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Lunch: ${meal.lunch}'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Dinner: ${meal.dinner}'),
          ),
        ],
      ),
    );
  } else {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Date: $formattedDate\nNo meal data available.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
