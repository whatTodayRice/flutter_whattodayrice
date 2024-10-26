import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/services/supabase_service.dart';
import 'package:flutter_whattodayrice/data/models/requests/supabase_request.dart';
import 'package:flutter_whattodayrice/data/models/trade_details.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SecondHandRemoteDataSource {
  final SupabaseService supabaseService;

  const SecondHandRemoteDataSource({required this.supabaseService});

  Future<ApiResponse<List<TradeDetails>>> getTradeDetailsList({required SupabaseRequest request}) =>
      supabaseService.getRecordList(
        request: request,
        fromJson: TradeDetails.fromJson,
      );

  Future<ApiResponse<TradeDetails>> getTradeDetails({required SupabaseRequest request}) => supabaseService.getRecord(
        request: request,
        fromJson: TradeDetails.fromJson,
      );
}
