import 'package:intl/intl.dart';

String getCurrentDate(String formattedString) {
  DateTime mealDate = DateTime.parse(formattedString);
  final DateFormat dateFormat = DateFormat('M월 d일 (E)', 'ko_KR');
  String formattedDate = dateFormat.format(mealDate);
  return formattedDate;
}
