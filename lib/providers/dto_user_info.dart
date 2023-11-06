import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import '../models/m_user.dart';
import 'dto_user_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StreamProvider<User>((ref) {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final userId = ref.watch(userIdProvider);
  if (userId.isNotEmpty) {
    return db.collection("users").doc(userId).snapshots().map((snapshot) {
      saveUserIdToSharedPreferences(userId);
      return User.fromFirestore(snapshot, null);

    });
  } else {

    return Stream.value(
        User(dormitoryType: DormitoryType.happiness.toString()));
  }
});

final userNickNameProvider = StateProvider<String>((ref) => "");


void saveUserIdToSharedPreferences(String userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
  print("  저장된 값 확인 :${prefs.getString('userId')}");
}

// SharedPreferences에서 데이터를 읽어서 출력하는 예제
Future<String?> readSharedPreferencesData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userId = prefs.getString('userId');
  return userId;
}