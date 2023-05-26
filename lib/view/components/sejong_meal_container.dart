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

    return _BuildContainer(
      height: height,
      width: width,
      weekdayIndex: weekdayIndex,
      mealFetcher: fetchSejongBreakFast,
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
      mealFetcher: fetchSejongLunch,
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
      mealFetcher: fetchSejongDinner,
    );
  }
}

class _BuildContainer extends StatelessWidget {
  const _BuildContainer({
    required this.height,
    required this.width,
    required this.weekdayIndex,
    required this.mealFetcher,
  });

  final double height;
  final double width;
  final int weekdayIndex;
  final FutureBuilder<List<String>> Function(int) mealFetcher;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1433,
      width: width * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: mealFetcher(weekdayIndex),
    );
  }
}

int getTodayIndex() {
  DateTime now = DateTime.now();
  int weekdayIndex = now.weekday + 1;
  print(weekdayIndex);
  return weekdayIndex;
}
