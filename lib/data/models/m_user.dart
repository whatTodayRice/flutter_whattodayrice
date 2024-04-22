import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String name;
  final String dormitoryType;
  final String? gender;
  final String? birthDate;

  const User({
    required this.name,
    this.birthDate = "1997-04-01",
    required this.dormitoryType,
    this.gender = '남',
  });

  User copyWith(
      {required String name,
      required String dormitoryType,
      required String gender,
      required String birthDate}) {
    return User(
        birthDate: birthDate,
        dormitoryType: dormitoryType,
        gender: gender,
        name: name);
  }

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      name: data?['name'],
      dormitoryType: data?['dormitory'],
      gender: data?['gender'] ?? "남",
      birthDate: data?['birthDate'] ?? "1997-04-01",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "dormitory": dormitoryType,
      "birthDate": birthDate ?? "1997-04-01",
      "gender": gender ?? "남",
    };
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      birthDate: data['birthDate'],
      dormitoryType: data['dormitory'],
      gender: data['gender'],
    );
  }
}
