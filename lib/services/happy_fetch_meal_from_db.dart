import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:intl/intl.dart';
import '../models/happy_meal.dart';

Future<List<HappyMealData?>> fetchWeeklyMealsFromDb(DateTime now) async {
  databaseFactory = databaseFactoryFfi;
  String dbPath = 'assets/db/meal.db';
  bool dbExists = File(dbPath).existsSync();
  if (!dbExists) {
    print('db파일이 존재하지 않습니다.');
    return List.filled(7, null); // DB 파일이 없는 경우 null로 채워진 6개의 요소를 가진 리스트 반환
  }

  List<HappyMealData?> weeklyMeals = [];

  Database database = await openDatabase(dbPath, readOnly: true);

  try {
    for (int i = 0; i < 6; i++) {
      DateTime date = now.add(Duration(days: i));
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      // SQL 쿼리를 수정하여 날짜에 맞게 결과를 필터링합니다.
      List<Map<String, dynamic>> results = await database.query(
        'menu',
        where: 'date = ?',
        whereArgs: [formattedDate],
      );

      HappyMealData? mealData;
      for (var item in results) {
        String? date = item['date'];
        String? breakfast = item['breakfast'];
        String? takeout = item['takeout'];
        String? lunch = item['lunch'];
        String? dinner = item['dinner'];

        mealData = HappyMealData(
          date: date,
          breakfast: breakfast,
          takeout: takeout,
          lunch: lunch,
          dinner: dinner,
        );
        break; // 해당 날짜의 데이터를 찾았으면 루프 종료
      }

      weeklyMeals.add(mealData); // 해당 날짜의 데이터를 리스트에 추가
    }

    return weeklyMeals;
  } catch (e) {
    print('데이터베이스에서 데이터를 가져오는 중 오류가 발생했습니다: $e');
    return List.filled(7, null); // 에러 발생 시 null로 채워진 6개의 요소를 가진 리스트 반환
  } finally {
    await database.close();
  }
}
