import 'dart:async';

import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  Profile? _userProfile;

  @override
  Future<ApiResponse<bool>> signInWithKakao() => authRemoteDataSource.signInWithKakao();

  @override
  Future<ApiResponse<AuthResponse>> signInByEmail({
    required String email,
    required String password,
  }) =>
      authRemoteDataSource.signInByEmail(
        email: email,
        password: password,
      );

  @override
  Future<ApiResponse<AuthResponse>> signUpNewUserByEmail({
    required String email,
    required String password,
  }) =>
      authRemoteDataSource.signUpNewUserByEmail(
        email: email,
        password: password,
      );

  @override
  Future<ApiResponse<void>> signOut() => authRemoteDataSource.signOut();

  @override
  Future<ApiResponse<Session>> getInitialSession() => authRemoteDataSource.getInitialSession();

  // TODO: 추후 cache 구현 필요
  @override
  Future<ApiResponse<Profile>> getUserProfile() async {
    final response = await authRemoteDataSource.getUserProfile();

    _userProfile = response.succeedData;

    return response;
  }

  @override
  Profile? get userProfile => _userProfile;
}
