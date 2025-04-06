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
    final newUserProfile = Profile(id: userId, nickname: nickname ?? "행긱 요정 $userId", blockedUsers: []);

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

  Future<ApiResponse> setBlockedUser({required int userId, required BlockedUserProfile profile}) async {
    try {
      await db
          .collection('users')
          .doc(userId.toString())
          .collection('blocked_users')
          .doc(profile.id.toString())
          .set(profile.toJson());

      Log.i('차단한 사용자 등록 성공: $userId => $profile');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('차단한 사용자 등록 실패: $userId => $profile');

      return const ServerException();
    }
  }

  Future<ApiResponse> deleteBlockUser({required int userId, required int blockedUserId}) async {
    try {
      await db
          .collection('users')
          .doc(userId.toString())
          .collection('blocked_users')
          .doc(blockedUserId.toString())
          .delete();

      Log.i('차단한 사용자 해제 성공: $userId => $blockedUserId');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('차단한 사용자 해제 실패: $userId => $blockedUserId');

      return const ServerException();
    }
  }
}
