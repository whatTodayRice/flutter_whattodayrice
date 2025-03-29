import 'dart:async';

import 'package:flutter_whattodayrice/data/data_sources/local/auth_local_data_source.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource, required this.authLocalDataSource});

  @override
  Future<ApiResponse<OAuthToken?>> signInWithKakaoTalk() => authRemoteDataSource.signInWithKakaoTalk().then(
        (value) async {
          if (value.succeedData != null) {
            updateAccessToken(value.succeedData!.accessToken);
          }

          return value;
        },
      );

  @override
  Future<ApiResponse<bool?>> signOut() => authRemoteDataSource.logoutKakao().then(
        (value) async {
          await clearAccessToken();

          return value;
        },
      );

  @override
  FutureOr<String?> getAccessTokenFromCache() => authLocalDataSource.getAccessToken();

  @override
  Future<void> updateAccessToken(String oauthToken) => authLocalDataSource.setAccessToken(oauthToken);

  @override
  Future<void> clearAccessToken() => authLocalDataSource.clearAccessToken();
}
