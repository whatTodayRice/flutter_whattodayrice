import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/theme/text_styles.dart';

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
    required this.width,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      '조식',
      style: TextStyle(fontSize: width * 0.0555, fontWeight: FontWeight.bold),
    );
  }
}

const notiTitleText = Text(
  '식단 업로드 알림을 받아보세요!',
  style: TextStyles.heading01,
);

const notiSubTitleText = Text(
  '어플에 접속하지 않아도, 내일 식단을 확인할 수 있어요',
  style: TextStyles.body04,
);
const notiNextWeekTitleText = Text('다음 주 식단이 업로드되었어요');

const String notiSettingText = '알림 설정하기';

const jumpToMainText = Text('다음에 설정할래요!', style: TextStyles.body04);

List<String> daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
