import 'package:flutter_whattodayrice/data/models/enum/enum_trade_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_details.freezed.dart';
part 'trade_details.g.dart';

@freezed
class TradeDetails with _$TradeDetails {
  const factory TradeDetails({
    required String id,
    @JsonKey(name: "post_id") required String postId,
    required int price,
    @JsonKey(name: "is_share") required bool isShared,
    @JsonKey(name: "location") required String tradeLocation,
    @JsonKey(name: "status", fromJson: TradeStatus.fromString) required TradeStatus tradeStatus,
    @JsonKey(name: "image_url") required String imageUrl,
  }) = _TradeDetails;

  factory TradeDetails.fromJson(Map<String, dynamic> json) => _$TradeDetailsFromJson(json);
}
