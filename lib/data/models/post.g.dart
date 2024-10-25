// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      postId: json['id'] as String,
      nickname: json['nickname'] as String,
      type: PostType.fromString(json['type'] as String),
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['created_at'] as String),
      tradeDetails: _readTradeDetails(json, 'trade_details') == null
          ? null
          : TradeDetails.fromJson(
              _readTradeDetails(json, 'trade_details') as Map<String, dynamic>),
      commentCount: (json['comment_count'] as num).toInt(),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.postId,
      'nickname': instance.nickname,
      'type': _$PostTypeEnumMap[instance.type]!,
      'title': instance.title,
      'content': instance.content,
      'created_at': const TimestampConverter().toJson(instance.createdAt),
      'trade_details': instance.tradeDetails,
      'comment_count': instance.commentCount,
    };

const _$PostTypeEnumMap = {
  PostType.free: 'free',
  PostType.question: 'question',
  PostType.secondHand: 'secondHand',
  PostType.none: 'none',
};
