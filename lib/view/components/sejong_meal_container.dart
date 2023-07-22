import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/services/sejong_fetch_meal.dart';

class SejongBreakfastContainer extends StatelessWidget {
  const SejongBreakfastContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    int weekdayIndex = getTodayIndex();
    // 여기를 내가 선택한 날짜의 인덱스가 전달되도록 수정해야한다.

    return _BuildContainer(
      height: height,
      width: width,
      mealFetcher: futurebuilderSejongBreakfast,
      weekdayIndex: weekdayIndex,
    );
  }
}

class SejongLunchContainer extends StatelessWidget {
  const SejongLunchContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    int weekdayIndex = getTodayIndex();

    return _BuildContainer(
      height: height,
      width: width,
      weekdayIndex: weekdayIndex,
      mealFetcher: futurebuilderSejongLunch,
    );
  }
}

class SejongDinnerContainer extends StatelessWidget {
  const SejongDinnerContainer(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    int weekdayIndex = getTodayIndex();

    return _BuildContainer(
      height: height,
      width: width,
      weekdayIndex: weekdayIndex,
      mealFetcher: futurebuilderSejongDinner,
    );
  }
}

class _BuildContainer extends StatelessWidget {
  const _BuildContainer({
    required this.height,
    required this.width,
    required this.mealFetcher,
    required this.weekdayIndex,
  });

  final double height;
  final double width;
  final int weekdayIndex;
  // final FutureBuilder<List<String>> Function(int) mealFetcher;
  final FutureBuilder<String?> Function() mealFetcher;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1433,
      width: width * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: mealFetcher(),
    );
  }
}

int getTodayIndex() {
  DateTime now = DateTime.now();
  int weekdayIndex = (now.weekday % 7) + 1;

  return weekdayIndex;
}
