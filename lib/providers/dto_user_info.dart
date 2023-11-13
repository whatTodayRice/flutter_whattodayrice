import 'dart:async';
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

      readDormitorySharedPreferencesData();
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
}


Future<String?> readUserIdSharedPreferencesData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userId = prefs.getString('userId');
  return userId;
}

Future<DormitoryType> readDormitorySharedPreferencesData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? dormitory = prefs.getString('dormitory');
  if (dormitory == "sejong1") {
    return DormitoryType.sejong1;
  }
  if(dormitory == "sejong2") {
    return DormitoryType.sejong2;
  }
  else {
    return DormitoryType.happiness;
  }
}

Future<List<String>> getUserIdStoredInFireStore() async {
  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  List<String> documentIds = [];
  QuerySnapshot querySnapshot = await userCollection.get();
  for(QueryDocumentSnapshot document in querySnapshot.docs) {
    documentIds.add(document.id);
  }
  print("documentIds.toString() : ${documentIds.toString()}");
  return documentIds;
}


Future<bool> isIDInFireStore(userId) async {
  final storedUserID = userId;
  if(storedUserID == null) {
    return false;
  }
  final firestoreUserIds = await getUserIdStoredInFireStore();
  return firestoreUserIds.contains(storedUserID);
}


final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

