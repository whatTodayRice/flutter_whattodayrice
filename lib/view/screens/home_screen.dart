import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/view/components/sejong_meal_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text('세종기숙사'), //기숙사에 따라 Text 내용 수정하기
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CalenderRow(
              width: width,
              height: height,
            ),
            SizedBox(
              height: height * 0.039,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: MealTimeTextRow(
                  mealTime: breakfastTime,
                  mealType: breakfast,
                  width: width,
                  height: height),
            ),
            SizedBox(
              height: height * 0.026,
            ),
            SejongBreakfastContainer(height: height, width: width),
            SizedBox(
              height: height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: MealTimeTextRow(
                  mealTime: lunchTime,
                  mealType: lunch,
                  width: width,
                  height: height),
            ),
            SizedBox(
              height: height * 0.026,
            ),
            SejongLunchContainer(height: height, width: width),
            SizedBox(
              height: height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: MealTimeTextRow(
                  mealTime: dinnerTime,
                  mealType: dinner,
                  width: width,
                  height: height),
            ),
            SizedBox(
              height: height * 0.026,
            ),
            SejongDinnerContainer(height: height, width: width),
          ],
        ),
      ),
    );
  }
}
