import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import '../models/m_user.dart';
import 'dto_user_id.dart';

final userProvider = StreamProvider<User>((ref) {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final userId = ref.watch(userIdProvider);
  if (userId.isNotEmpty) {
    return db.collection("users").doc(userId).snapshots().map((snapshot) {
      return User.fromFirestore(snapshot, null);
    });
  } else {
    return Stream.value(
        User(dormitoryType: DormitoryType.happiness.toString()));
  }
});

final userNickNameProvider = StateProvider<String>((ref) => "");
