import 'package:flutter/material.dart';
import './view/screens/completed.dart';

void main() {
  runApp(WhatTodayRiceApp());
}

class WhatTodayRiceApp extends StatelessWidget {
  const WhatTodayRiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('세종 기숙사'),
          centerTitle: true,
        ),
        body: Container(
          child: Text('오밥뭐'),
        ),
      ),
    );
  }
}
