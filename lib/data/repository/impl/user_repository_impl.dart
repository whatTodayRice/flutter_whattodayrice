import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  Profile? _userProfile;

  @override
  Profile? getUserProfileFromCache() => _userProfile;

  @override
  Future<ApiResponse<Profile?>> getUserProfile() async {
    final user = await remoteDataSource.getKakaoUserProfile();

    if (user.succeedData == null) {
      return const UnknownException();
    }

    final response = await remoteDataSource.getUserProfile(userId: user.succeedData!.id);

    if (response.succeedData == null) {
      await remoteDataSource.setUserProfile(
        userId: user.succeedData!.id,
        nickname: user.succeedData!.kakaoAccount?.profile?.nickname,
      );
    }

    return await remoteDataSource.getUserProfile(userId: user.succeedData!.id).then(
      (value) {
        if (value.succeedData != null) {
          _userProfile = value.succeedData!;
        }

        return value;
      },
    );
  }

  @override
  Future<ApiResponse> updateBlockedUsers({required int userId, required List<int> blockedUserIds}) =>
      remoteDataSource.updateBlockedUsers(userId: userId, blockedUserIds: blockedUserIds).then(
        (value) {
          if (value.isSucceed == true) {
            _userProfile = _userProfile?.copyWith(blockedUserIds: [...blockedUserIds]);
          }

          return value;
        },
      );
}
