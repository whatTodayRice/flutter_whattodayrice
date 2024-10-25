import 'package:flutter_whattodayrice/data/models/converter/date_time_converter.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_post_type.dart';
import 'package:flutter_whattodayrice/data/models/trade_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

TradeDetails? _readTradeDetails(Map<dynamic, dynamic> json, String key) {
  if (json["type"] == "trade" && json.containsKey("trade_details")) {
    return TradeDetails.fromJson(json["trade_details"]);
  }

  return null;
}

@freezed
class Post with _$Post {
  const factory Post({
    @JsonKey(name: "id") required String postId,
    required String nickname,
    @JsonKey(name: "type", fromJson: PostType.fromString) required PostType type,
    required String title,
    required String content,
    @TimestampConverter() @JsonKey(name: "created_at") required String createdAt,
    @JsonKey(name: "trade_details", readValue: _readTradeDetails) TradeDetails? tradeDetails,
    required int commentCount,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
