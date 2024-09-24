import 'package:flutter/cupertino.dart';
import 'package:flutter_whattodayrice/data/data_source/core/api_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;

  static SupabaseService? _instance;

  static SupabaseService get instance => _instance ??= SupabaseService._internal();

  SupabaseService._internal();

  Future<ApiResponse<bool>> signInWithKakao() async {
    try {
      final bool response = await _supabase.auth.signInWithOAuth(OAuthProvider.kakao);

      return SucceedResponse(response);
    } on AuthException catch (error) {
      debugPrint("-------signInWithKako Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    } catch (error) {
      debugPrint("-------signInWithKako Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    }
  }

  Future<ApiResponse<AuthResponse>> signUpNewUserByEmail({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await _supabase.auth.signUp(email: email, password: password);

      return SucceedResponse(response);
    } on AuthException catch (error) {
      debugPrint("-------signUpNewUserByEmail Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    } catch (error) {
      debugPrint("-------signUpNewUserByEmail Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    }
  }

  Future<ApiResponse<AuthResponse>> signInByEmail({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await _supabase.auth.signInWithPassword(email: email, password: password);

      return SucceedResponse(response);
    } on AuthException catch (error) {
      debugPrint("-------SignInByEmail Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    } catch (error) {
      debugPrint("-------SignInByEmail Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    }
  }

  Future<ApiResponse<void>> signOut() async {
    try {
      await _supabase.auth.signOut();

      return const SucceedResponse(null);
    } on AuthException catch (error) {
      debugPrint("-------SignOut Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    } catch (error) {
      debugPrint("-------SignOut Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    }
  }

  Future<ApiResponse<Session>> getInitialSession() async {
    try {
      final Session? session = _supabase.auth.currentSession;

      return SucceedResponse(session);
    } on AuthException catch (error) {
      debugPrint("-------getInitialSession Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    } catch (error) {
      debugPrint("-------getInitialSession Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    }
  }

  Future<ApiResponse<User>> getUserProfile() async {
    try {
      final User? user = _supabase.auth.currentUser;

      if (user == null) {
        return const SucceedResponse(null);
      }

      return SucceedResponse(user);
    } on AuthException catch (error) {
      debugPrint("-------getUserProfile Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    } catch (error) {
      debugPrint("-------getUserProfile Error-------");
      debugPrint(error.toString());

      return FailureResponse(error.toString());
    }
  }
}
