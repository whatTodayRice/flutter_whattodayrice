// 주어진 날짜의 요일 인덱스 계산 (월요일=0, 일요일=6) - 한국 시간 기준
import '../../../data/models/enum/enum_meal_type.dart';

int getDayIndex(DateTime dateTime) {
  // 한국 시간 기준으로 변환 (UTC+9)
  final koreaTime = getKoreaDateTime(dateTime);
  return (koreaTime.weekday - 1) % 7; // 월요일이 0, 일요일이 6
}

DateTime getKoreaDateTime(DateTime dateTime) => dateTime.toUtc().add(const Duration(hours: 9));

// 오늘 날짜의 요일 인덱스 계산 (한국 시간 기준)
int getCurrentDayIndex() {
  return getDayIndex(DateTime.now());
}

MealType getCurrentAvailableMealType() {
  // 한국 시간으로 현재 시간 구하기
  final now = getKoreaDateTime(DateTime.now());

  // 식사 시작 시간 정의
  final breakfastStart = DateTime(now.year, now.month, now.day, 7, 30);
  final breakfastEnd = DateTime(now.year, now.month, now.day, 9, 30);

  final lunchStart = DateTime(now.year, now.month, now.day, 11, 30);
  final lunchEnd = DateTime(now.year, now.month, now.day, 14, 00);

  final dinnerStart = DateTime(now.year, now.month, now.day, 16, 50);
  final dinnerEnd = DateTime(now.year, now.month, now.day, 19, 00);

  // 시간 비교를 통해 MealType 결정
  if (now.isAfter(breakfastStart) && now.isBefore(breakfastEnd)) {
    return MealType.breakfast;
  } else if (now.isAfter(lunchStart) && now.isBefore(lunchEnd)) {
    return MealType.lunch;
  } else if (now.isAfter(dinnerStart) && now.isBefore(dinnerEnd)) {
    return MealType.dinner;
  } else {
    return MealType.none;
  }
}
