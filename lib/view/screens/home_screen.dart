import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/happy_meal_container';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final mainScreenHeight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text('행복기숙사'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CalenderRow(
                mainScreenWidth: mainScreenWidth,
                mainScreenHeight: mainScreenHeight),
            SizedBox(
              height: mainScreenHeight * 0.039,
            ),
            MealTimeTextRow(
                mainScreenWidth: mainScreenWidth,
                mainScreenHeight: mainScreenHeight),
            SizedBox(
              height: mainScreenHeight * 0.026,
            ),
            happyMealContainer(
                height: mainScreenHeight, mainScreenWidth: mainScreenWidth),
            SizedBox(
              height: mainScreenHeight * 0.1,
            ),
            happyMealContainer(
                height: mainScreenHeight, mainScreenWidth: mainScreenWidth),
            SizedBox(
              height: mainScreenHeight * 0.1,
            ),
            happyMealContainer(
                height: mainScreenHeight, mainScreenWidth: mainScreenWidth),
          ],
        ),
      ),
    );
  }
}
