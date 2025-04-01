import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/utils/log/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' hide Profile;

@LazySingleton()
class UserRemoteDataSource {
  final db = FirebaseFirestore.instance;

  Future<ApiResponse<Profile?>> getUserProfile({required int userId}) async {
    final docSnap = await db.collection('users').doc(userId.toString()).get();
    final profileMap = docSnap.data();

    if (profileMap == null) {
      return const SucceedResponse(null);
    }

    return SucceedResponse(Profile.fromJson(profileMap));
  }

  Future<void> setUserProfile({required int userId, String? nickname}) async {
    final newUserProfile = Profile(id: userId, nickname: nickname ?? "행긱 요정 $userId", blockedUserIds: []);

    await db.collection('users').doc(userId.toString()).set(newUserProfile.toJson()).then(
          (value) => Log.i("새로운 유저 추가됨. UserId: $userId"),
        );
  }

  Future<ApiResponse<User>> getKakaoUserProfile() async {
    try {
      final response = await UserApi.instance.me();

      return SucceedResponse(response);
    } catch (e) {
      Log.i('카카오 유저 정보 가져오기 실패 $e');

      return const UnknownException();
    }
  }

  Future<ApiResponse> updateBlockedUsers({required int userId, required List<int> blockedUserIds}) async {
    try {
      await db.collection('users').doc(userId.toString()).update({
        'blocked_user_ids': [...blockedUserIds]
      });

      Log.i('차단한 사용자 업데이트 성공: $userId => $blockedUserIds');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('차단한 사용자 업데이트 실패: $userId => $blockedUserIds');

      return const ServerException();
    }
  }
}
