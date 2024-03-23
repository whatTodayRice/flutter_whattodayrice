import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_whattodayrice/data/models/m_user.dart';
import 'package:flutter_whattodayrice/presentation/providers/dto_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoService {
  void createUserInfo(User user) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('users')
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, options) => user.toFirestore(),
        )
        .add(user)
        .then(
      (doc) {
        final newUserId = doc.id;
        saveUserIdToSharedPreferences(newUserId);
      },
    );
  }

  Future<User> readUserInfo() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('userId')!;
    final ref = db.collection('users').doc(userId).withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, options) => user.toFirestore(),
        );
    final docSnap = await ref.get();
    final user = docSnap.data();
    print('유저 서비스에서 유저 받아오기 성공: ${user!.gender}');

    return user;
  }

  void updateUserDormitory(String dormitoryType) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    final Map<String, dynamic> dormitoryMap = {'dormitory': dormitoryType};
    await db
        .collection('users')
        .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, options) => user.toFirestore())
        .doc(userId)
        .update(dormitoryMap);
  }
}
