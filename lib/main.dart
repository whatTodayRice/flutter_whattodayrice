//import 'package:flutter_whattodayrice/view/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/view/screens/table_calendar_practice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/screens/home_screen.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';

void main() async {
  // HttpClient httpClinet = HttpClient();
  // httpClinet.badCertificateCallback =
  //     (X509Certificate cert, String host, int port) => true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(useMaterial3: true),
      routes: {
        SettingsScreen.routeName: (context) => const SettingsScreen(),
      },
      // theme: kTextStyleGuide,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomeScreen()),
    );
  }
}
