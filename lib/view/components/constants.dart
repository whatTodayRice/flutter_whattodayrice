import 'package:flutter/material.dart';

const kMainScreenTitleText = Text('세종기숙사');
const kCompleteTitleText = Text(
  '모든 설정을 완료했습니다!',
  style: TextStyle(
      fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),
);
const kCompletedSubTitleText = Text(
  '정해진 시간에 알림을 보내드릴게요!',
  style: TextStyle(fontSize: 15.0, color: Colors.black),
);
const kCompletedCheckCircle = Icon(
  Icons.check_circle,
  size: 120.0,
  color: Colors.grey,
);
const kStartText = Text(
  '시작하기',
  style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
);

class kMealAvailableTimeText extends StatelessWidget {
  const kMealAvailableTimeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      '8:00 ~ 9:30',
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }
}

class kMealCategoryIcon extends StatelessWidget {
  const kMealCategoryIcon({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.04615,
      height: height * 0.02132,
      child: const Icon(
        Icons.sunny,
        size: 18,
      ),
    );
  }
}

class kMealCategoryText extends StatelessWidget {
  const kMealCategoryText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      '조식',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
