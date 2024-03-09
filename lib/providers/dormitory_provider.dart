import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dto_user_info.dart';

final dormitoryProvider = StateProvider<DormitoryType>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final dormitoryString = sharedPreferences.getString('dormitory');

  if (dormitoryString != null && dormitoryString.isNotEmpty) {
    return dormitoryFromString(dormitoryString);
  } else {
    return DormitoryType.happiness;
  }
});

Future<void> saveDormitory(DormitoryType dormitory) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('dormitory', dormitoryToString(dormitory));
}

String dormitoryToString(DormitoryType dormitory) {
  return dormitory.toString();
}

DormitoryType dormitoryFromString(String dormitoryString) {
  return DormitoryType.values.firstWhere(
      (element) => dormitoryToString(element) == dormitoryString,
      orElse: () => DormitoryType.sejong1);
}
