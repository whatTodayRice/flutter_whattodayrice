import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/requests/supabase_request.dart';
import 'package:flutter_whattodayrice/data/models/trade_details.dart';

abstract interface class SecondHandRepository {
  Future<ApiResponse<List<TradeDetails>>> getTradeDetailsList({required SupabaseRequest request});

  Future<ApiResponse<TradeDetails>> getTradeDetails({required SupabaseRequest request});
}
