import 'package:flutter_whattodayrice/data/models/converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  @JsonSerializable()
  const factory Comment({
    required String id,
    required String nickname,
    required String content,
    @TimestampConverter() required String createdAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
