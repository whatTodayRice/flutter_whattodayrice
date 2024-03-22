import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';

@immutable
class UserUiState {
  final DormitoryType dormitoryType;

  const UserUiState({this.dormitoryType = DormitoryType.happiness});

  UserUiState copyWith({DormitoryType? dormitoryType}) {
    return UserUiState(dormitoryType: dormitoryType ?? this.dormitoryType);
  }
}
