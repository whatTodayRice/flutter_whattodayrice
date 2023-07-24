//import 'package:flutter_whattodayrice/view/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/view/screens/table_calendar_practice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/models/dummy_happy_meal.dart';
import 'package:flutter_whattodayrice/services/happy_fetch_meal_from_db.dart';
import 'package:flutter_whattodayrice/view/screens/home_screen.dart';

import 'models/happy_meal.dart';

void main() async {
  // HttpClient httpClinet = HttpClient();
  // httpClinet.badCertificateCallback =
  //     (X509Certificate cert, String host, int port) => true;
  dummyWeeklyData;
  runApp(MyApp(dummyWeeklyData));
}

class MyApp extends StatelessWidget {
  final List<HappyMealData?> weeklyMeals;

  const MyApp(this.weeklyMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // SettingsScreen.routeName: (context) => const SettingsScreen(),
      },
      // theme: kTextStyleGuide,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomeScreen(weeklyMeals)),
    );
  }
}
