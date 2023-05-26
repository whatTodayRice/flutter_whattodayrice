import 'package:flutter/material.dart';
//import 'package:flutter_whattodayrice/view/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/view/screens/table_calendar_practice.dart';
import 'package:flutter_whattodayrice/view/screens/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          // appBar: AppBar(
          //   title: const Text('세종 기숙사'),
          //   centerTitle: true,
          // ),
          //페이지 확인을 위한 버튼 추가함.
          body: HomeScreen()),
    );
  }
}
