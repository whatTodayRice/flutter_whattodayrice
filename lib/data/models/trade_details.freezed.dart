// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeDetails _$TradeDetailsFromJson(Map<String, dynamic> json) {
  return _TradeDetails.fromJson(json);
}

/// @nodoc
mixin _$TradeDetails {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "post_id")
  String get postId => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: "is_share")
  bool get isShared => throw _privateConstructorUsedError;
  @JsonKey(name: "location")
  String get tradeLocation => throw _privateConstructorUsedError;
  @JsonKey(name: "status", fromJson: TradeStatus.fromString)
  TradeStatus get tradeStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "image_url")
  String get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this TradeDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeDetailsCopyWith<TradeDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeDetailsCopyWith<$Res> {
  factory $TradeDetailsCopyWith(
          TradeDetails value, $Res Function(TradeDetails) then) =
      _$TradeDetailsCopyWithImpl<$Res, TradeDetails>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: "post_id") String postId,
      int price,
      @JsonKey(name: "is_share") bool isShared,
      @JsonKey(name: "location") String tradeLocation,
      @JsonKey(name: "status", fromJson: TradeStatus.fromString)
      TradeStatus tradeStatus,
      @JsonKey(name: "image_url") String imageUrl});
}

/// @nodoc
class _$TradeDetailsCopyWithImpl<$Res, $Val extends TradeDetails>
    implements $TradeDetailsCopyWith<$Res> {
  _$TradeDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? price = null,
    Object? isShared = null,
    Object? tradeLocation = null,
    Object? tradeStatus = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      isShared: null == isShared
          ? _value.isShared
          : isShared // ignore: cast_nullable_to_non_nullable
              as bool,
      tradeLocation: null == tradeLocation
          ? _value.tradeLocation
          : tradeLocation // ignore: cast_nullable_to_non_nullable
              as String,
      tradeStatus: null == tradeStatus
          ? _value.tradeStatus
          : tradeStatus // ignore: cast_nullable_to_non_nullable
              as TradeStatus,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeDetailsImplCopyWith<$Res>
    implements $TradeDetailsCopyWith<$Res> {
  factory _$$TradeDetailsImplCopyWith(
          _$TradeDetailsImpl value, $Res Function(_$TradeDetailsImpl) then) =
      __$$TradeDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: "post_id") String postId,
      int price,
      @JsonKey(name: "is_share") bool isShared,
      @JsonKey(name: "location") String tradeLocation,
      @JsonKey(name: "status", fromJson: TradeStatus.fromString)
      TradeStatus tradeStatus,
      @JsonKey(name: "image_url") String imageUrl});
}

/// @nodoc
class __$$TradeDetailsImplCopyWithImpl<$Res>
    extends _$TradeDetailsCopyWithImpl<$Res, _$TradeDetailsImpl>
    implements _$$TradeDetailsImplCopyWith<$Res> {
  __$$TradeDetailsImplCopyWithImpl(
      _$TradeDetailsImpl _value, $Res Function(_$TradeDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? price = null,
    Object? isShared = null,
    Object? tradeLocation = null,
    Object? tradeStatus = null,
    Object? imageUrl = null,
  }) {
    return _then(_$TradeDetailsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      isShared: null == isShared
          ? _value.isShared
          : isShared // ignore: cast_nullable_to_non_nullable
              as bool,
      tradeLocation: null == tradeLocation
          ? _value.tradeLocation
          : tradeLocation // ignore: cast_nullable_to_non_nullable
              as String,
      tradeStatus: null == tradeStatus
          ? _value.tradeStatus
          : tradeStatus // ignore: cast_nullable_to_non_nullable
              as TradeStatus,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeDetailsImpl implements _TradeDetails {
  const _$TradeDetailsImpl(
      {required this.id,
      @JsonKey(name: "post_id") required this.postId,
      required this.price,
      @JsonKey(name: "is_share") required this.isShared,
      @JsonKey(name: "location") required this.tradeLocation,
      @JsonKey(name: "status", fromJson: TradeStatus.fromString)
      required this.tradeStatus,
      @JsonKey(name: "image_url") required this.imageUrl});

  factory _$TradeDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeDetailsImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: "post_id")
  final String postId;
  @override
  final int price;
  @override
  @JsonKey(name: "is_share")
  final bool isShared;
  @override
  @JsonKey(name: "location")
  final String tradeLocation;
  @override
  @JsonKey(name: "status", fromJson: TradeStatus.fromString)
  final TradeStatus tradeStatus;
  @override
  @JsonKey(name: "image_url")
  final String imageUrl;

  @override
  String toString() {
    return 'TradeDetails(id: $id, postId: $postId, price: $price, isShared: $isShared, tradeLocation: $tradeLocation, tradeStatus: $tradeStatus, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isShared, isShared) ||
                other.isShared == isShared) &&
            (identical(other.tradeLocation, tradeLocation) ||
                other.tradeLocation == tradeLocation) &&
            (identical(other.tradeStatus, tradeStatus) ||
                other.tradeStatus == tradeStatus) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, postId, price, isShared,
      tradeLocation, tradeStatus, imageUrl);

  /// Create a copy of TradeDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeDetailsImplCopyWith<_$TradeDetailsImpl> get copyWith =>
      __$$TradeDetailsImplCopyWithImpl<_$TradeDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeDetailsImplToJson(
      this,
    );
  }
}

abstract class _TradeDetails implements TradeDetails {
  const factory _TradeDetails(
          {required final String id,
          @JsonKey(name: "post_id") required final String postId,
          required final int price,
          @JsonKey(name: "is_share") required final bool isShared,
          @JsonKey(name: "location") required final String tradeLocation,
          @JsonKey(name: "status", fromJson: TradeStatus.fromString)
          required final TradeStatus tradeStatus,
          @JsonKey(name: "image_url") required final String imageUrl}) =
      _$TradeDetailsImpl;

  factory _TradeDetails.fromJson(Map<String, dynamic> json) =
      _$TradeDetailsImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: "post_id")
  String get postId;
  @override
  int get price;
  @override
  @JsonKey(name: "is_share")
  bool get isShared;
  @override
  @JsonKey(name: "location")
  String get tradeLocation;
  @override
  @JsonKey(name: "status", fromJson: TradeStatus.fromString)
  TradeStatus get tradeStatus;
  @override
  @JsonKey(name: "image_url")
  String get imageUrl;

  /// Create a copy of TradeDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeDetailsImplCopyWith<_$TradeDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
