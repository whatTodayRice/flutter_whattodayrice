// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatePostRequestImpl _$$CreatePostRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePostRequestImpl(
      userId: (json['user_id'] as num).toInt(),
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
      sellTypeIndex: (json['sell_type_index'] as num).toInt(),
      location: json['location'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$CreatePostRequestImplToJson(
        _$CreatePostRequestImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'price': instance.price,
      'sell_type_index': instance.sellTypeIndex,
      'location': instance.location,
      'image_url': instance.imageUrl,
    };
