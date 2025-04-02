import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';

abstract interface class UserRepository {
  Profile? getUserProfileFromCache();

  Future<ApiResponse<Profile?>> getUserProfile();

  Future<ApiResponse> updateBlockedUsers({required int userId, required List<int> blockedUserIds});
}
