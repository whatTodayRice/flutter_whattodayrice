import 'package:flutter/services.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/utils/log/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

@LazySingleton()
class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<ApiResponse<OAuthToken?>> signInWithKakaoTalk() async {
    try {
      // TODO: 추후 KakaoTalk으로 바꾸기(에뮬에 카카오톡 안깔려 있어서 계정 로그인으로 함)
      final oauthToken = await UserApi.instance.loginWithKakaoAccount();

      return SucceedResponse(oauthToken);
    } catch (e) {
      Log.i('카카오톡으로 로그인 실패 $e');

      if (e is PlatformException && e.code == 'CANCELED') {
        return const ServerException(message: "사용자의 의도적인 로그인 취소");
      }

      return const UnknownException();
    }
  }

  Future<ApiResponse<bool?>> logoutKakao() async {
    try {
      await UserApi.instance.logout();
      Log.i('로그아웃 성공, SDK에서 토큰 폐기');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('로그아웃 실패, SDK에서 토큰 폐기 $e');

      return const UnknownException();
    }
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
}
