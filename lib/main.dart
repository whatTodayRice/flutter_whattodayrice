import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/screens/selectdormitory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('세종 기숙사'),
            centerTitle: true,
          ),
          //페이지 확인을 위한 버튼 추가함.
          body: const SelectDormitory()),
    );
  }
}
