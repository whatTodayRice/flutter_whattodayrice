import 'package:flutter_whattodayrice/data/data_source/user_info_data_source.dart';
import 'package:flutter_whattodayrice/data/models/m_user.dart';

class UserRepository {
  final UserInfoRemoteDataSource _userInfoRemoteDataSource;

  UserRepository(this._userInfoRemoteDataSource);

  void creaetUserInfo(Map<String, dynamic> data) {
    User user = User.fromMap(data);
    _userInfoRemoteDataSource.createUserInfo(user: user);
  }

  Future<User> readUserInfo() async {
    return _userInfoRemoteDataSource.readUserInfo();
  }

  void updateUserDormitory({required String dormitoryType}) {
    _userInfoRemoteDataSource.updateUserDormitoy(dormitoryType: dormitoryType);
  }
}
