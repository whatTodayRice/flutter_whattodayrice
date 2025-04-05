import 'dart:async';

import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';

abstract interface class AuthRepository {
  FutureOr<String?> getAccessTokenFromCache();

  Future<ApiResponse> signInWithKakaoTalk();

  Future<ApiResponse<bool?>> signOut();

  Future<void> updateAccessToken(String oauthToken);

  Future<void> clearAccessToken();
}
