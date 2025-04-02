// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatePostRequestImpl _$$CreatePostRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePostRequestImpl(
      id: json['id'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      price: (json['price'] as num?)?.toInt(),
      location: json['location'] as String?,
      imageUrl: json['image_url'] as String?,
      sellStatus: (json['sell_status'] as num?)?.toInt(),
      parentPostId: json['parent_post_id'] as String?,
    );

Map<String, dynamic> _$$CreatePostRequestImplToJson(
        _$CreatePostRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'title': instance.title,
      'content': instance.content,
      'price': instance.price,
      'location': instance.location,
      'image_url': instance.imageUrl,
      'sell_status': instance.sellStatus,
      'parent_post_id': instance.parentPostId,
    };
