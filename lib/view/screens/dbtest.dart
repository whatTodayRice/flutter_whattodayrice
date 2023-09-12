import 'package:sqflite/sqflite.dart';

//SQLite 데이터 베이스 연결하기
Future<Database> openDatabase(String path) async {
  return await openDatabase(path);
}

//데이터 베이스에서 데이터 가져오기
Future<void> fetchDatFromDatabase() async {
  String path =
      'C:UsersHeo\flutterWhatTodayRice\flutter_whattodayriceassetsdbWhatTodayRiceDB.db';
  final db = await openDatabase(path);
  final results = await db.query('sejong_menu');

  for (var row in results) {
    print(row[0]);
  }

  await db.close();
}
