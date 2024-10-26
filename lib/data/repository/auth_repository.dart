import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRepository {
  Future<ApiResponse<bool>> signInWithKakao();

  Future<ApiResponse<AuthResponse>> signUpNewUserByEmail({required String email, required String password});

  Future<ApiResponse<AuthResponse>> signInByEmail({required String email, required String password});

  Future<ApiResponse<void>> signOut();

  Future<ApiResponse<Session>> getInitialSession();

  Future<ApiResponse<Profile>> getUserProfile();

  Profile? get userProfile;
}
