import 'dart:async';
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
      readSharedPreferencesData();
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
  print("sp에 저장된 userId 읽기  : $userId");
  return userId;
}

Future<List<String>> getDocumentIds() async {
  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  List<String> documentIds = [];
  QuerySnapshot querySnapshot = await userCollection.get();
  for(QueryDocumentSnapshot document in querySnapshot.docs) {
    documentIds.add(document.id);
  }
  print("documentIds.toString() : ${documentIds.toString()}");
  return documentIds;
}


Future<String?> getStoredUserId() async {
  final SharedPreferences prefs= await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

Future<bool> isIDInFireStore(userId) async {
  final storedUserID = userId;
  if(storedUserID == null) {
    return false;
  }
  final firestoreUserIds = await getDocumentIds();
  print("포함여부 :${firestoreUserIds.contains(storedUserID)}");
  return firestoreUserIds.contains(storedUserID);
}


