import 'dart:io';
import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/dormitory.dart';
import '../models/meal.dart';

Future<List<MealData?>> fetchMealDataFromDB(
    DateTime now, DormitoryType dormitoryType) async {
  databaseFactory = databaseFactoryFfi;
  String dbPath = 'assets/db/meal.db';
  bool dbExists = File(dbPath).existsSync();
  if (!dbExists) {
    print('db파일이 존재하지 않습니다.');
  }

  List<MealData?> weeklyMeals = [];

  Database database = await openDatabase(dbPath, readOnly: true);

  try {
    for (int i = 0; i < 6; i++) {
      DateTime date = now.add(Duration(days: i));
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      List<Map<String, dynamic>> results;

      if (dormitoryType == DormitoryType.sejong) {
        // 기숙사 타입이 세종인 경우 세종기숙사 데이터를 가져옵니다.
        results = await database.query(
          'sejong_menu',
          where: 'date = ?',
          whereArgs: [formattedDate],
        );
      } else {
        // 기숙사 타입이 행복인 경우 행복기숙사 데이터를 가져옵니다.
        results = await database.query(
          'menu',
          where: 'date = ?',
          whereArgs: [formattedDate],
        );
      }

      MealData? mealData;
      for (var item in results) {
        if (dormitoryType == DormitoryType.sejong) {
          String modifiedItem = item.toString().replaceAll('\n', ' , ');
          RegExp breakfastRegex = RegExp(r'breakfast: (.*?)(?=, \w+:|$)');
          RegExp lunchRegex = RegExp(r'lunch: (.*?)(?=, \w+:|$)');
          RegExp dinnerRegex = RegExp(r'dinner: (.*?)(?=, \w+:|$)');

          String? date = item['date'];
          String? breakfast = breakfastRegex.firstMatch(modifiedItem)?.group(1);
          String? lunch = lunchRegex.firstMatch(modifiedItem)?.group(1);
          String? dinner = dinnerRegex.firstMatch(modifiedItem)?.group(1);

          mealData = MealData(
            date: date,
            breakfast: breakfast,
            lunch: lunch,
            dinner: dinner,
          );
        } else {
          String? date = item['date'];
          String? breakfast = item['breakfast'];
          String? takeout = item['takeout'];
          String? lunch = item['lunch'];
          String? dinner = item['dinner'];

          mealData = MealData(
            date: date,
            breakfast: breakfast,
            takeout: takeout,
            lunch: lunch,
            dinner: dinner,
          );
        }

        break; // 해당 날짜의 데이터를 찾았으면 루프 종료
      }

      weeklyMeals.add(mealData); // 해당 날짜의 데이터를 리스트에 추가
    }

    return weeklyMeals;
  } catch (e) {
    print('데이터베이스에서 데이터를 가져오는 중 오류가 발생했습니다: $e');
    return List.filled(6, null); // 에러 발생 시 null로 채워진 6개의 요소를 가진 리스트 반환
  } finally {
    await database.close();
  }
}