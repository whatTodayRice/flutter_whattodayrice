//import 'package:flutter_whattodayrice/view/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/view/screens/table_calendar_practice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/services/sejong_fetch_meal_db.dart';
import 'package:flutter_whattodayrice/view/screens/home_screen.dart';

void main() async {
  // HttpClient httpClinet = HttpClient();
  // httpClinet.badCertificateCallback =
  //     (X509Certificate cert, String host, int port) => true;
  DateTime now = DateTime.now();
  print(now);
  List<MealData?> weeklyMeals = await fetchWeeklyMealsFromDb(now);

  print(weeklyMeals);
  runApp(MyApp(weeklyMeals));
}

class MyApp extends StatelessWidget {
  final List<MealData?> weeklyMeals;

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
