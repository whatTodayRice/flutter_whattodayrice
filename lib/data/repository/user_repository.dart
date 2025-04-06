import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';

abstract interface class UserRepository {
  Profile? getUserProfileFromCache();

  Future<ApiResponse<Profile?>> initUserProfile();

  Future<ApiResponse> setBlockedUser({required int userId, required BlockedUserProfile profile});

  Future<ApiResponse> deleteBlockedUser({required int userId, required int blockedUserId});

  void clearUserProfile();
}
