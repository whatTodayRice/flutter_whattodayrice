import 'dart:async';

import 'package:flutter_whattodayrice/data/data_source/auth_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/data_source/core/api_response.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  /* 초기화 부분 */
  late final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl._internal(AuthRemoteDataSource authRemoteDataSource) {
    _authRemoteDataSource = authRemoteDataSource;
  }

  static AuthRepositoryImpl? _instance;

  factory AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource}) {
    _instance ??= AuthRepositoryImpl._internal(authRemoteDataSource);

    return _instance!;
  }

  AuthRepositoryImpl getInstance() {
    if (_instance == null) {
      throw Exception("AuthRepositoryImpl instance를 먼저 초기화해주세요");
    }

    return _instance!;
  }

  @override
  Future<ApiResponse<bool>> signInWithKakao() => _authRemoteDataSource.signInWithKakao();

  @override
  Future<ApiResponse<AuthResponse>> signInByEmail({
    required String email,
    required String password,
  }) =>
      _authRemoteDataSource.signInByEmail(
        email: email,
        password: password,
      );

  @override
  Future<ApiResponse<AuthResponse>> signUpNewUserByEmail({
    required String email,
    required String password,
  }) =>
      _authRemoteDataSource.signUpNewUserByEmail(
        email: email,
        password: password,
      );

  @override
  Future<ApiResponse<void>> signOut() => _authRemoteDataSource.signOut();

  @override
  Future<ApiResponse<Session>> getInitialSession() => _authRemoteDataSource.getInitialSession();

  // TODO: 추후 cache 구현 필요
  @override
  Future<ApiResponse<User>> getUserProfile() async {
    return await _authRemoteDataSource.getUserProfile();
  }
}
