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

    return Container(
      height: height * 0.1433,
      width: width * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [fetchSejongBreakFast(weekdayIndex)],
      ),
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
    return Container(
      height: height * 0.1433,
      width: width * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //식단 데이터 요일별로

          fetchSejongLunch(weekdayIndex)
        ],
      ),
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
    return Container(
      height: height * 0.1433,
      width: width * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //식단 데이터 분리하기 !
          fetchSejongDinner(weekdayIndex)
        ],
      ),
    );
  }
}

//오늘 요일 인뎃스
int getTodayIndex() {
  DateTime now = DateTime.now();
  int weekdayIndex = now.weekday;
  return weekdayIndex;
}
