import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/services/supabase_service.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class AuthRemoteDataSource {
  final SupabaseService supabaseService;

  const AuthRemoteDataSource({required this.supabaseService});

  Future<ApiResponse<bool>> signInWithKakao() => supabaseService.signInWithKakao();

  Future<ApiResponse<AuthResponse>> signUpNewUserByEmail({
    required String email,
    required String password,
  }) =>
      supabaseService.signUpNewUserByEmail(
        email: email,
        password: password,
      );

  Future<ApiResponse<AuthResponse>> signInByEmail({
    required String email,
    required String password,
  }) =>
      supabaseService.signInByEmail(
        email: email,
        password: password,
      );

  Future<ApiResponse<void>> signOut() => supabaseService.signOut();

  Future<ApiResponse<Session>> getInitialSession() => supabaseService.getInitialSession();

  Future<ApiResponse<Profile>> getUserProfile() => supabaseService.getUserProfile();
}
