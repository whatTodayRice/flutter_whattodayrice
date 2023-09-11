import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:intl/intl.dart';

Future<String?> fetchSejongFromdb() async {
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));
  String formattedToday = DateFormat('yyyy-MM-dd').format(now);
  String formattedTomorrow = DateFormat('yyyy-MM-dd').format(tomorrow);

  databaseFactory = databaseFactoryFfi;
  String dbPath = 'assets/db/meal.db';
  bool dbExists = File(dbPath).existsSync();
  if (!dbExists) {
    print('db파일이 존재하지 않습니다.');
    //에러 처리하기
  }

  Database database = await openDatabase(dbPath, readOnly: true);

  // List<Map<String, dynamic>> happyResults = await database.query('menu');
  List<Map<String, dynamic>> sejongResults =
      await database.query('sejong_menu');

  for (var item in sejongResults) {
    //db의 date가 오늘 날짜와 동일하다면
    if (item['date'] == formattedToday) {
      String modifiedItem = item.toString().replaceAll('\n', ' , ');
      //아침
      RegExp breakfastRegex = RegExp(r'breakfast: (.*?)(?=, \w+:|$)');
      String? breakfast = breakfastRegex.firstMatch(modifiedItem)?.group(1);
      return breakfast;
    }
  }
  await database.close();
  return null;
}

Future<String?> fetchSejongLunchFromdb() async {
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));
  String formattedToday = DateFormat('yyyy-MM-dd').format(now);
  String formattedTomorrow = DateFormat('yyyy-MM-dd').format(tomorrow);

  databaseFactory = databaseFactoryFfi;
  String dbPath = 'assets/db/meal.db';
  bool dbExists = File(dbPath).existsSync();
  if (!dbExists) {
    print('db파일이 존재하지 않습니다.');
    //에러 처리하기
  }

  Database database = await openDatabase(dbPath, readOnly: true);

  // List<Map<String, dynamic>> happyResults = await database.query('menu');
  List<Map<String, dynamic>> sejongResults =
      await database.query('sejong_menu');

  for (var item in sejongResults) {
    //db의 date가 오늘 날짜와 동일하다면
    if (item['date'] == formattedToday) {
      String modifiedItem = item.toString().replaceAll('\n', ' , ');

      //점심
      RegExp lunchRegex = RegExp(r'lunch: (.*?)(?=, \w+:|$)');
      String? lunch = lunchRegex.firstMatch(modifiedItem)?.group(1);
      return lunch;
    }
  }
  await database.close();
  return null;
}

Future<String?> fetchSejongDinnerFromdb() async {
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));
  String formattedToday = DateFormat('yyyy-MM-dd').format(now);
  String formattedTomorrow = DateFormat('yyyy-MM-dd').format(tomorrow);

  databaseFactory = databaseFactoryFfi;
  String dbPath = 'assets/db/meal.db';
  bool dbExists = File(dbPath).existsSync();
  if (!dbExists) {
    print('db파일이 존재하지 않습니다.');
    //에러 처리하기
  }

  Database database = await openDatabase(dbPath, readOnly: true);

  // List<Map<String, dynamic>> happyResults = await database.query('menu');
  List<Map<String, dynamic>> sejongResults =
      await database.query('sejong_menu');

  for (var item in sejongResults) {
    //db의 date가 오늘 날짜와 동일하다면
    if (item['date'] == formattedToday) {
      String modifiedItem = item.toString().replaceAll('\n', ' , ');

      //저녁
      RegExp dinnerRegex = RegExp(r'dinner: (.*?)(?=, \w+:|$)');
      String? dinner = dinnerRegex.firstMatch(modifiedItem)?.group(1);
      return dinner;
    }
  }
  await database.close();
  return null;
}
