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
  const kMealAvailableTimeText({super.key, required this.mealTime});
  final String mealTime;
  @override
  Widget build(BuildContext context) {
    return Text(
      mealTime,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }
}

String sejongBreakfastTime = '7:30 ~ 9:00';
String sejongLunchTime = '11:30 ~ 13:30';
String sejongDinnerTime = '17:00 ~ 18:30';

String sejongVacationBreakfastTime = '7:30 ~ 9:00';
String sejongVacationLunchTime = '12:00 ~ 13:30';
String sejongVacaitonDinnerTime = '17:00 ~ 18:30';

String happyBreakfastWeekTime = '7:30 ~ 9 30';
String happyLunchWeekTime = '11:30 ~ 14:00';
String happyDinnerWeekTime = '16:50 ~ 19:00';

String happyBreakfastTime = '08:00 ~ 09:30';
String happyLunchTime = '11:30 ~ 13:30';
String happyDinnerTime = '17:30 ~ 18:45';

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
        Icons.sunny, //시간에 따라 아이콘 변경하기
        size: 18,
      ),
    );
  }
}
//아침 ,점심, 저녁 아이콘 변경하기

class kMealCategoryText extends StatelessWidget {
  const kMealCategoryText({
    super.key,
    required this.mealType,
    required this.width,
  });
  final double width;
  final String mealType;

  @override
  Widget build(BuildContext context) {
    return Text(
      mealType,
      style: TextStyle(fontSize: width * 0.0555, fontWeight: FontWeight.bold),
    );
  }
}

var kTextStyleGuide = ThemeData(
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 18 / 12,
    ),
    displayMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
  ),
);

const String breakfast = '조식';
const String lunch = '중식';
const String dinner = '석식';

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

const notyExplainText =
    '매일 저녁 19시에 다음 날 식단이 업데이트 되었다는 소식을\n아래와 같이 팝업을 통해 알려줍니다.';
