import 'dart:async';

import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

abstract interface class AuthRepository {
  FutureOr<String?> getAccessTokenFromCache();

  Future<ApiResponse<OAuthToken?>> signInWithKakaoTalk();

  Future<ApiResponse<bool?>> signOut();

  Future<void> updateAccessToken(String oauthToken);

  Future<void> clearAccessToken();
}
