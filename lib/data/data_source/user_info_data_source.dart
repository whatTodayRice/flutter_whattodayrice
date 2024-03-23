import 'package:flutter_whattodayrice/data/models/m_user.dart';
import 'package:flutter_whattodayrice/data/services/user_info_service.dart';

class UserInfoRemoteDataSource {
  final UserInfoService _userInfoService;

  UserInfoRemoteDataSource(this._userInfoService);

  void createUserInfo({required User user}) {
    _userInfoService.createUserInfo(user);
  }

  Future<User> readUserInfo() async {
    return _userInfoService.readUserInfo();
  }

  void updateUserDormitoy({required String dormitoryType}) {
    _userInfoService.updateUserDormitory(dormitoryType);
  }
}
