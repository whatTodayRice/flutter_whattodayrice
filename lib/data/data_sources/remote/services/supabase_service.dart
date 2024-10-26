import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/data/models/requests/supabase_request.dart';
import 'package:flutter_whattodayrice/utils/log/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  SupabaseService();

  Future<ApiResponse<T>> getRecord<T>({
    required SupabaseRequest request,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      if (request.table == null) {
        return const NotFoundException(message: "Table을 입력해주세요.");
      }

      _logStart(method: "GET", table: request.table!, columns: request.columns);

      final response = await _supabase.from(request.table!).select().eq('id', request.columns![0]).single();

      _logEnd(data: response, method: "GET");

      return SucceedResponse(fromJson(response));
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResponse<List<T>>> getRecordList<T>({
    required SupabaseRequest request,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      if (request.table == null) {
        return const NotFoundException(message: "Table을 입력해주세요.");
      }

      _logStart(method: "GET RECORD LIST", table: request.table!, columns: request.columns);

      PostgrestTransformBuilder<PostgrestList> query = _supabase
          .from(request.table!)
          .select(
            request.columns?.join(',') ?? "*",
          )
          .eq(
            "type",
            request.columnValue![0],
          );

      if (request.limit != null) {
        query = query.limit(request.limit!);
      }

      if (request.offSet != null) {
        query = query.range(request.offSet!, request.offSet! + request.limit! - 1);
      }

      if (request.orderBy != null) {
        for (var order in request.orderBy!) {
          query = query.order(order, ascending: request.isAscending!);
        }
      }

      final response = await query;

      final List<T> results = (response as List).map((record) => fromJson(record as Map<String, dynamic>)).toList();

      _logEnd(data: results, method: "GET RECORD LIST");

      return SucceedResponse(results);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResponse<T>> insertRecord<T>({
    required SupabaseRequest request,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      if (request.table == null) {
        return const NotFoundException(message: "Table을 입력해주세요.");
      }

      _logStart(method: "INSERT", table: request.table!, columns: request.columns);

      final response = await _supabase.from(request.table!).insert(request.data!).select().single();

      _logEnd(data: response, method: "INSERT");

      return SucceedResponse(fromJson(response));
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResponse> deleteRecord<T>({required SupabaseRequest request}) async {
    try {
      if (request.table == null) {
        return const NotFoundException(message: "Table을 입력해주세요.");
      }

      _logStart(method: "DELETE", table: request.table!, columns: request.columns);

      final response = await _supabase.from(request.table!).delete().eq(request.columns![0], request.columnValue![0]);

      _logEnd(data: response, method: "DELETE");

      return const SucceedResponse(true);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResponse<T>> callSingleFunction<T>({
    required SupabaseRequest request,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await _supabase.rpc(request.function!, params: request.params);

      // 응답 로깅
      Log.i('Function response: $response');

      if (response is! Map<String, dynamic>) {
        Log.e('Expected Map<String, dynamic>, but got: ${response.runtimeType}');
        throw const FormatException('잘못된 레코드 형식');
      }

      final result = fromJson(response);

      _logEnd(method: "RPC SINGLE", data: result);

      return SucceedResponse(result);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResponse<List<T>>> callListFunction<T>({
    required SupabaseRequest request,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await _supabase.rpc(request.function!, params: request.params);

      // 응답 로깅
      Log.i('Function response: $response');

      if (response is! List) {
        // 응답이 리스트가 아닌 경우 처리
        Log.e('Expected List response, but got: ${response.runtimeType}');
        return const ServerException(message: "잘못된 응답 형식");
      }

      final List<T> data = response.map((record) {
        if (record is! Map<String, dynamic>) {
          Log.e('Expected Map<String, dynamic>, but got: ${record.runtimeType}');
          throw const FormatException('잘못된 레코드 형식');
        }
        return fromJson(record);
      }).toList();

      return SucceedResponse(data);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResponse<bool>> signInWithKakao() async {
    try {
      final bool response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.kakao,
        authScreenLaunchMode: LaunchMode.externalApplication,
      );

      return SucceedResponse(response);
    } catch (error) {
      return handleError(error);
    }
  }

  Future<ApiResponse<AuthResponse>> signUpNewUserByEmail({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await _supabase.auth.signUp(email: email, password: password);

      return SucceedResponse(response);
    } catch (error) {
      return handleError(error);
    }
  }

  Future<ApiResponse<AuthResponse>> signInByEmail({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await _supabase.auth.signInWithPassword(email: email, password: password);

      return SucceedResponse(response);
    } catch (error) {
      return handleError(error);
    }
  }

  Future<ApiResponse<void>> signOut() async {
    try {
      await _supabase.auth.signOut();

      return const SucceedResponse(null);
    } catch (error) {
      return handleError(error);
    }
  }

  Future<ApiResponse<Session>> getInitialSession() async {
    try {
      final Session? session = _supabase.auth.currentSession;

      return SucceedResponse(session);
    } catch (error) {
      return handleError(error);
    }
  }

  Future<ApiResponse<Profile>> getUserProfile() async {
    try {
      final String? userId = _supabase.auth.currentUser?.id;

      if (userId == null) {
        return const SucceedResponse(null);
      }

      final response = await _supabase.from('users').select().eq('id', userId).single();

      final profile = Profile.fromJson(response);

      return SucceedResponse(profile);
    } catch (error) {
      return handleError(error);
    }
  }

  /// Logger
  void _logStart({
    required String method,
    required String table,
    required dynamic columns,
  }) {
    Log.i("-------Supabase $method start-------");
    Log.i('Table: $table');
    Log.i('Column: $columns');
  }

  void _logEnd({
    required String method,
    required dynamic data,
  }) {
    Log.i('Data: $data');
    Log.i("-------Supabase $method end-------");
  }

  /// Error handling
  ApiResponse<T> handleError<T>(dynamic error) {
    try {
      if (error == null) return const UnknownException();

      if (error is PostgrestException) {
        return ServerException(
          message: error.message,
          code: error.code,
          details: error.details,
          hint: error.hint,
        );
      }

      if (error is AuthException) {
        return ServerException(
          message: error.message,
          code: error.code,
        );
      }

      return const UnknownException();
    } catch (e, st) {
      Log.i('handleError: $e');
      Log.i('handleError: $st');
      return const UnknownException();
    }
  }
}
