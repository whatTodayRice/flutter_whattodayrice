import 'package:flutter_whattodayrice/data/models/dormitory.dart';

int getUserAccessDatePageIndex(DateTime dateTime, DormitoryType dormitoryType) {
  int userAccessWeekday = dateTime.weekday;

  if (dormitoryType == DormitoryType.happiness) {
    userAccessWeekday = userAccessWeekday - 1;
  } else {
    if (userAccessWeekday == 7) {
      userAccessWeekday = userAccessWeekday - 7;
    }
  }
  return userAccessWeekday;
}
