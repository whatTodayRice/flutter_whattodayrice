import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/common/utils/converter/dormmitory_enum.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/data/models/m_user.dart';

@immutable
class UserUiState {
  final String? name;
  final DormitoryType? dormitoryType;
  final String? gender;
  final DateTime? birthDate;

  const UserUiState(
      {this.dormitoryType, this.birthDate, this.gender, this.name});

  UserUiState copyWith(
      {DormitoryType? dormitoryType,
      String? name,
      String? gender,
      DateTime? birthDate}) {
    return UserUiState(
        dormitoryType: dormitoryType ?? this.dormitoryType,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        birthDate: birthDate ?? this.birthDate);
  }

  factory UserUiState.fromUser(User user) {
    return UserUiState(
      name: user.name,
      dormitoryType: getDormitoryTypeEnum(user.dormitoryType),
      gender: user.gender,
      birthDate: DateTime.parse(user.birthDate!),
    );
  }
}
