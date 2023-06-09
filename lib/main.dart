//import 'package:flutter_whattodayrice/view/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/screens/selectdormitory.dart';
//import 'package:flutter_whattodayrice/view/screens/table_calendar_practice.dart';
import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  databaseFactory = databaseFactoryFfi;
  String dbPath = 'assets/db/meal.db';
  bool dbExists = File(dbPath).existsSync();
  if (!dbExists) {
    print('db파일이 존재하지 않습니다.');
    return;
  }
  Database database = await openDatabase(dbPath, readOnly: true);

  List<Map<String, dynamic>> results = await database.query('menu');
  List<Map<String, dynamic>> sejongResults =
      await database.query('sejong_menu');

  print('행복db: $results');
  print('세종db: $sejongResults');

  await database.close();

  HttpClient httpClinet = HttpClient();
  httpClinet.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
}



  // initializeDateFormatting().then((_) {
  //   runApp(const MyApp());
  // });

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       routes: {
//         // SettingsScreen.routeName: (context) => const SettingsScreen(),
//       },
//       // theme: kTextStyleGuide,
//       debugShowCheckedModeBanner: false,
//       // home: Scaffold(body: HomeScreen()),
//     );
//   }
// }
