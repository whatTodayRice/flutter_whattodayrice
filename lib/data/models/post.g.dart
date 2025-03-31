// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      postId: json['id'] as String,
      userId: (json['user_id'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      price: (json['price'] as num?)?.toInt(),
      isShared: json['is_shared'] as bool?,
      location: json['location'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.postId,
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'title': instance.title,
      'content': instance.content,
      'price': instance.price,
      'is_shared': instance.isShared,
      'location': instance.location,
      'created_at': instance.createdAt?.toIso8601String(),
    };
