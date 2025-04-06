import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:flutter_whattodayrice/utils/log/logger.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  Profile? _userProfile;

  @override
  Profile? getUserProfileFromCache() => _userProfile;

  @override
  Future<ApiResponse<Profile?>> initUserProfile() async {
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
  Future<ApiResponse> setBlockedUser({required int userId, required BlockedUserProfile profile}) =>
      remoteDataSource.setBlockedUser(userId: userId, profile: profile).then(
        (value) {
          if (value.isSucceed == true) {
            final updateBlockedUsers = [..._userProfile?.blockedUsers ?? [], profile];

            _userProfile = _userProfile?.copyWith(blockedUsers: [...updateBlockedUsers]);
          }

          return value;
        },
      );

  @override
  Future<ApiResponse> deleteBlockedUser({required int userId, required int blockedUserId}) =>
      remoteDataSource.deleteBlockUser(userId: userId, blockedUserId: blockedUserId).then(
        (value) {
          if (value.isSucceed != true) {
            return value;
          }

          final curBlockedUsers = [..._userProfile?.blockedUsers ?? []];
          final updatedBlockedUsers = curBlockedUsers.where((e) => e.id != blockedUserId).toList();

          _userProfile = _userProfile?.copyWith(blockedUsers: [...updatedBlockedUsers]);

          return value;
        },
      );

  @override
  void clearUserProfile() {
    _userProfile = null;

    Log.i('UserProfile Clear Succeed');
  }
}
