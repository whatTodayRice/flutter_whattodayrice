import 'package:flutter_whattodayrice/data/models/dormitory.dart';

DormitoryType getDormitoryTypeEnum(String dormitortType) {
  if (dormitortType == "DormitoryType.happiness") {
    return DormitoryType.happiness;
  } else if (dormitortType == "DormitoryType.sejong1") {
    return DormitoryType.sejong1;
  } else {
    return DormitoryType.sejong2;
  }
}
