import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? name;
  final DormitoryType dormitoryType;

  User({this.name, required this.dormitoryType});

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      name: data?['name'],
      dormitoryType: data?['dormitory'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (dormitoryType != null) "dormitory": dormitoryType,
    };
  }
}
