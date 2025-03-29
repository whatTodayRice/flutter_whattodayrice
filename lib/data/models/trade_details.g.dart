// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeDetailsImpl _$$TradeDetailsImplFromJson(Map<String, dynamic> json) =>
    _$TradeDetailsImpl(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      price: (json['price'] as num).toInt(),
      isShared: json['is_share'] as bool,
      tradeLocation: json['location'] as String,
      tradeStatus: TradeStatus.fromString(json['status'] as String),
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$$TradeDetailsImplToJson(_$TradeDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postId,
      'price': instance.price,
      'is_share': instance.isShared,
      'location': instance.tradeLocation,
      'status': _$TradeStatusEnumMap[instance.tradeStatus]!,
      'image_url': instance.imageUrl,
    };

const _$TradeStatusEnumMap = {
  TradeStatus.selling: 'selling',
  TradeStatus.reserved: 'reserved',
  TradeStatus.sold: 'sold',
  TradeStatus.none: 'none',
};
