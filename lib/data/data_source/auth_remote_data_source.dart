import 'package:flutter_whattodayrice/data/data_source/core/api_response.dart';
import 'package:flutter_whattodayrice/data/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  late final SupabaseService _supabaseService;

  static AuthRemoteDataSource? _instance;

  AuthRemoteDataSource._internal(SupabaseService supabaseService) {
    _supabaseService = supabaseService;
  }

  factory AuthRemoteDataSource({required SupabaseService supabaseService}) {
    _instance ??= AuthRemoteDataSource._internal(supabaseService);

    return _instance!;
  }

  AuthRemoteDataSource getInstance() {
    if (_instance == null) {
      throw Exception("AuthRemoteDataSource instance를 초기화 해주세요.");
    }

    return _instance!;
  }

  Future<ApiResponse<bool>> signInWithKakao() => _supabaseService.signInWithKakao();

  Future<ApiResponse<AuthResponse>> signUpNewUserByEmail({
    required String email,
    required String password,
  }) =>
      _supabaseService.signUpNewUserByEmail(
        email: email,
        password: password,
      );

  Future<ApiResponse<AuthResponse>> signInByEmail({
    required String email,
    required String password,
  }) =>
      _supabaseService.signInByEmail(
        email: email,
        password: password,
      );

  Future<ApiResponse<void>> signOut() => _supabaseService.signOut();

  Future<ApiResponse<Session>> getInitialSession() => _supabaseService.getInitialSession();

  Future<ApiResponse<User>> getUserProfile() => _supabaseService.getUserProfile();
}
