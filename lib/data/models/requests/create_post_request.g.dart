// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatePostRequestImpl _$$CreatePostRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePostRequestImpl(
      userId: (json['user_id'] as num).toInt(),
      nickname: json['nickname'] as String,
      title: json['title'] as String,
      price: (json['price'] as num?)?.toInt(),
      isShared: json['is_shared'] as bool,
      location: json['location'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$CreatePostRequestImplToJson(
        _$CreatePostRequestImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'title': instance.title,
      'price': instance.price,
      'is_shared': instance.isShared,
      'location': instance.location,
      'image_url': instance.imageUrl,
    };
