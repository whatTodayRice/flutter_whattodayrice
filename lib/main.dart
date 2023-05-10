import 'package:flutter/material.dart';

void main() {
  runApp(const WhatTodayRiceApp());
}

class WhatTodayRiceApp extends StatelessWidget {
  const WhatTodayRiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('세종 기숙사'),
          centerTitle: true,
        ),
        body: Container(
          child: const Text('오밥뭐'),
        ),
      ),
    );
  }
}
