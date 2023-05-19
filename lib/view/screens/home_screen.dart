import 'package:flutter/material.dart';

import '../components/calender_row.dart';
import '../components/happy_meal_container.dart';
import '../components/meal_time_row.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
              width: width,
              height: height,
            ),
            SizedBox(
              height: height * 0.039,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: MealTimeTextRow(width: width, height: height),
            ),
            SizedBox(
              height: height * 0.026,
            ),
            happyMealContainer(height: height, width: width),
            SizedBox(
              height: height * 0.1,
            ),
            happyMealContainer(height: height, width: width),
            SizedBox(
              height: height * 0.1,
            ),
            happyMealContainer(height: height, width: width),
          ],
        ),
      ),
    );
  }
}
