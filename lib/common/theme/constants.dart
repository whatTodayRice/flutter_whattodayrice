import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/common/theme/text_styles.dart';

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

class MealAvailableTimeText extends StatelessWidget {
  const MealAvailableTimeText({super.key, required this.mealTime});
  final String mealTime;
  @override
  Widget build(BuildContext context) {
    return Text(mealTime, style: Theme.of(context).textTheme.bodyMedium!
        // .copyWith(color: const Color(0xFF5C5C5C)),
        //todo 다른 텍스트와 같게 디폴트로 설정할 경우 다크모드로 변경해도 정상적으로 보여요 :> 유저입장에서 다른 컬러로 설정하는것이 시각적으로 더 좋은 효과가 있을까요?
        );
  }
}

String sejongBreakfastTime = '7:30 ~ 9:00';
String sejongLunchTime = '11:30 ~ 13:30';
String sejongDinnerTime = '17:00 ~ 18:30';

String sejongVacationBreakfastTime = '7:30 ~ 9:00';
String sejongVacationLunchTime = '12:00 ~ 13:30';
String sejongVacaitonDinnerTime = '17:00 ~ 18:30';

String happyBreakfastWeekTime = '7:30 ~ 9:30';
String happyLunchWeekTime = '11:30 ~ 14:00';
String happyDinnerWeekTime = '16:50 ~ 19:00';

String happyBreakfastTime = '08:00 ~ 09:30';
String happyLunchTime = '11:30 ~ 13:30';
String happyDinnerTime = '17:30 ~ 18:45';

class MealCategoryIcon extends StatelessWidget {
  const MealCategoryIcon({
    super.key,
    required this.mealType,
  });

  final MealType mealType;

  static const Map<dynamic, IconData> mealIcons = {
    MealType.breakfast: Icons.wb_twilight_rounded,
    MealType.lunch: Icons.sunny,
    MealType.dinner: Icons.mode_night_rounded,
    // 추가적인 식사 시간 타입 및 아이콘을 여기에 추가할 수 있습니다.
  };

  @override
  Widget build(BuildContext context) {
    final selectedIcon = mealIcons[mealType] ?? Icons.sunny;
    return Icon(
      selectedIcon, //시간에 따라 아이콘 변경하기
      size: 18.w,
    );
  }
}
//아침 ,점심, 저녁 아이콘 변경하기

class MealCategoryText extends StatelessWidget {
  const MealCategoryText({
    super.key,
    required this.mealType,
  });
  final String mealType;

  @override
  Widget build(BuildContext context) {
    return Text(
      mealType,
      style: Theme.of(context).textTheme.headlineMedium,
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

const Map<dynamic, dynamic> mealTypes = {
  MealType.breakfast: '조식',
  MealType.lunch: '중식',
  MealType.dinner: '석식'
};

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
