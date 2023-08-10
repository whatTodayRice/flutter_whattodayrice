//import 'package:flutter_whattodayrice/view/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/view/screens/table_calendar_practice.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/models/dummy_happy_meal.dart';
import 'package:flutter_whattodayrice/view/screens/home_screen.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';

void main() async {
  dummyWeeklyData;
  runApp(MyApp(dummyWeeklyData));



// Function to convert AdaptiveThemeMode to ThemeMode
ThemeMode convertToThemeMode(AdaptiveThemeMode adaptiveThemeMode) {
  switch (adaptiveThemeMode) {
    case AdaptiveThemeMode.light:
      return ThemeMode.light;
    case AdaptiveThemeMode.dark:
      return ThemeMode.dark;
    case AdaptiveThemeMode.system:
    default:
      return ThemeMode.system;
  }
}

// Function to convert AdaptiveThemeMode to ThemeMode
ThemeMode convertToThemeMode(AdaptiveThemeMode adaptiveThemeMode) {
  switch (adaptiveThemeMode) {
    case AdaptiveThemeMode.light:
      return ThemeMode.light;
    case AdaptiveThemeMode.dark:
      return ThemeMode.dark;
    case AdaptiveThemeMode.system:
    default:
      return ThemeMode.system;
  }
}

class MyApp extends StatelessWidget {
  final List<HappyMealData?> weeklyMeals;
  const MyApp(this.weeklyMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        routes: {
          SettingsScreen.routeName: (context) => const SettingsScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: HomeScreen(weeklyMeals)),
      ),
    );
  }
}
