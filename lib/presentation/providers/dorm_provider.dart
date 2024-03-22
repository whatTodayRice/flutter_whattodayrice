import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/presentation/ui_state/user.dart';

class DormitoryViewModel extends ChangeNotifier {
  UserUiState _userUiState = const UserUiState();

  UserUiState get userUiState => _userUiState;

  void changeDormitory(DormitoryType dormitoryType) {
    _userUiState = _userUiState.copyWith(dormitoryType: dormitoryType);
    notifyListeners();
  }
}

final dormsProvder =
    ChangeNotifierProvider<DormitoryViewModel>((ref) => DormitoryViewModel());
