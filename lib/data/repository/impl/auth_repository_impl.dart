import 'dart:async';

import 'package:flutter_whattodayrice/data/data_sources/local/auth_local_data_source.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource, required this.authLocalDataSource});

  @override
  Future<ApiResponse> signInWithKakaoTalk() async {
    final oAuthTokenResponse = await authRemoteDataSource.signInWithKakaoTalk();

    if (oAuthTokenResponse.succeedData == null) {
      return oAuthTokenResponse;
    }

    updateAccessToken(oAuthTokenResponse.succeedData!.accessToken);

    return await authRemoteDataSource.signInWithCredential(oauthToken: oAuthTokenResponse.succeedData!);
  }

  @override
  Future<ApiResponse<bool?>> signOut() async {
    final kakaoResponse = await authRemoteDataSource.logoutKakao();

    if (kakaoResponse.isSucceed != true) {
      return kakaoResponse;
    }

    await clearAccessToken();

    return await authRemoteDataSource.signOutFromFirebaseAuth();
  }

  @override
  FutureOr<String?> getAccessTokenFromCache() => authLocalDataSource.getAccessToken();

  @override
  Future<void> updateAccessToken(String oauthToken) => authLocalDataSource.setAccessToken(oauthToken);

  @override
  Future<void> clearAccessToken() => authLocalDataSource.clearAccessToken();
}
