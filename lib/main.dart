import 'package:flutter/material.dart';

void main() {
  runApp(WhatTodayRiceApp());
}

class WhatTodayRiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('세종기숙사'),
        ),
      ),
    );
  }
}
