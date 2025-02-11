import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/second_hand_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/models/requests/supabase_request.dart';
import 'package:flutter_whattodayrice/data/models/trade_details.dart';
import 'package:flutter_whattodayrice/data/repository/second_hand_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SecondHandRepository)
class SecondHandRepositoryImpl implements SecondHandRepository {
  final SecondHandRemoteDataSource secondHandRemoteDataSource;

  const SecondHandRepositoryImpl({required this.secondHandRemoteDataSource});

  @override
  Future<ApiResponse<TradeDetails>> getTradeDetails({required SupabaseRequest request}) =>
      secondHandRemoteDataSource.getTradeDetails(
        request: request,
      );

  @override
  Future<ApiResponse<List<TradeDetails>>> getTradeDetailsList({required SupabaseRequest request}) =>
      secondHandRemoteDataSource.getTradeDetailsList(
        request: request,
      );
}
