// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String?,
      parentPostId: json['parent_post_id'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      imageUrl: json['image_url'] as String?,
      price: (json['price'] as num?)?.toInt(),
      location: json['location'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      sellStatus: (json['sell_status'] as num?)?.toInt(),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_post_id': instance.parentPostId,
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'title': instance.title,
      'content': instance.content,
      'image_url': instance.imageUrl,
      'price': instance.price,
      'location': instance.location,
      'created_at': instance.createdAt?.toIso8601String(),
      'sell_status': instance.sellStatus,
      'comments': instance.comments,
    };
