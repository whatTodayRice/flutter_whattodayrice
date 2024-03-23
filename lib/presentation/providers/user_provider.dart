import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/common/utils/converter/dormmitory_enum.dart';
import 'package:flutter_whattodayrice/data/data_source/user_info_data_source.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/data/models/m_user.dart';
import 'package:flutter_whattodayrice/data/repository/user_repo.dart';
import 'package:flutter_whattodayrice/data/services/user_info_service.dart';
import 'package:flutter_whattodayrice/presentation/ui_state/user_ui_state.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  UserViewModel(this._userRepository);

  UserUiState _userUiState = const UserUiState();
  UserUiState get userUiState => _userUiState;

  Future<void> readUserInfo() async {
    User user = await _userRepository.readUserInfo();
    print("유저 뷰모델에서 유저 받아옴: ${user.dormitoryType}");
    _userUiState = _userUiState.copyWith(
      name: user.name,
      gender: user.gender,
      birthDate: DateTime.parse(user.birthDate!),
      dormitoryType: getDormitoryTypeEnum(user.dormitoryType),
    );
    print("유저 뷰모델 UiState 변경 성공: ${_userUiState.dormitoryType}");
    notifyListeners();
  }

  void changeUserDormitory(DormitoryType dormitoryType) async {
    print("유저 뷰모델에서 변경할 기숙사 값 받음: $dormitoryType");
    String userDormitoryType = dormitoryType.toString();
    print("유저 뷰모델에서 Repo의 updateUserDormitory 호출 ");
    _userRepository.updateUserDormitory(dormitoryType: userDormitoryType);
    print("유저 뷰모델에서 Repo의 updateUserDormitory 작업 완료");
    User user = await _userRepository.readUserInfo();
    print("유저 뷰모델에서 변경된 User 정보 받아옴: ${user.dormitoryType}");
    _userUiState = _userUiState.copyWith(
        dormitoryType: getDormitoryTypeEnum(user.dormitoryType));
    print(
        "유저 뷰모델에서 변경된 기숙사 값을 받아서 uiState 저장 완료: ${_userUiState.dormitoryType}");
    notifyListeners();
  }
}

final userProivder = ChangeNotifierProvider<UserViewModel>(
  (ref) => UserViewModel(
    UserRepository(
      UserInfoRemoteDataSource(
        UserInfoService(),
      ),
    ),
  ),
);
