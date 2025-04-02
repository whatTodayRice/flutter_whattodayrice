// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_post_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReportPostRequest _$ReportPostRequestFromJson(Map<String, dynamic> json) {
  return _ReportPostRequest.fromJson(json);
}

/// @nodoc
mixin _$ReportPostRequest {
  int? get writerId => throw _privateConstructorUsedError;
  String? get postId => throw _privateConstructorUsedError;
  String? get commentId => throw _privateConstructorUsedError;
  int? get reasonTypeIndex => throw _privateConstructorUsedError;
  String? get detailReason => throw _privateConstructorUsedError;

  /// Serializes this ReportPostRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportPostRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportPostRequestCopyWith<ReportPostRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportPostRequestCopyWith<$Res> {
  factory $ReportPostRequestCopyWith(
          ReportPostRequest value, $Res Function(ReportPostRequest) then) =
      _$ReportPostRequestCopyWithImpl<$Res, ReportPostRequest>;
  @useResult
  $Res call(
      {int? writerId,
      String? postId,
      String? commentId,
      int? reasonTypeIndex,
      String? detailReason});
}

/// @nodoc
class _$ReportPostRequestCopyWithImpl<$Res, $Val extends ReportPostRequest>
    implements $ReportPostRequestCopyWith<$Res> {
  _$ReportPostRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportPostRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? writerId = freezed,
    Object? postId = freezed,
    Object? commentId = freezed,
    Object? reasonTypeIndex = freezed,
    Object? detailReason = freezed,
  }) {
    return _then(_value.copyWith(
      writerId: freezed == writerId
          ? _value.writerId
          : writerId // ignore: cast_nullable_to_non_nullable
              as int?,
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      commentId: freezed == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonTypeIndex: freezed == reasonTypeIndex
          ? _value.reasonTypeIndex
          : reasonTypeIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      detailReason: freezed == detailReason
          ? _value.detailReason
          : detailReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportPostRequestImplCopyWith<$Res>
    implements $ReportPostRequestCopyWith<$Res> {
  factory _$$ReportPostRequestImplCopyWith(_$ReportPostRequestImpl value,
          $Res Function(_$ReportPostRequestImpl) then) =
      __$$ReportPostRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? writerId,
      String? postId,
      String? commentId,
      int? reasonTypeIndex,
      String? detailReason});
}

/// @nodoc
class __$$ReportPostRequestImplCopyWithImpl<$Res>
    extends _$ReportPostRequestCopyWithImpl<$Res, _$ReportPostRequestImpl>
    implements _$$ReportPostRequestImplCopyWith<$Res> {
  __$$ReportPostRequestImplCopyWithImpl(_$ReportPostRequestImpl _value,
      $Res Function(_$ReportPostRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportPostRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? writerId = freezed,
    Object? postId = freezed,
    Object? commentId = freezed,
    Object? reasonTypeIndex = freezed,
    Object? detailReason = freezed,
  }) {
    return _then(_$ReportPostRequestImpl(
      writerId: freezed == writerId
          ? _value.writerId
          : writerId // ignore: cast_nullable_to_non_nullable
              as int?,
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      commentId: freezed == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonTypeIndex: freezed == reasonTypeIndex
          ? _value.reasonTypeIndex
          : reasonTypeIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      detailReason: freezed == detailReason
          ? _value.detailReason
          : detailReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportPostRequestImpl implements _ReportPostRequest {
  const _$ReportPostRequestImpl(
      {this.writerId,
      this.postId,
      this.commentId,
      this.reasonTypeIndex,
      this.detailReason});

  factory _$ReportPostRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportPostRequestImplFromJson(json);

  @override
  final int? writerId;
  @override
  final String? postId;
  @override
  final String? commentId;
  @override
  final int? reasonTypeIndex;
  @override
  final String? detailReason;

  @override
  String toString() {
    return 'ReportPostRequest(writerId: $writerId, postId: $postId, commentId: $commentId, reasonTypeIndex: $reasonTypeIndex, detailReason: $detailReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportPostRequestImpl &&
            (identical(other.writerId, writerId) ||
                other.writerId == writerId) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.reasonTypeIndex, reasonTypeIndex) ||
                other.reasonTypeIndex == reasonTypeIndex) &&
            (identical(other.detailReason, detailReason) ||
                other.detailReason == detailReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, writerId, postId, commentId, reasonTypeIndex, detailReason);

  /// Create a copy of ReportPostRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportPostRequestImplCopyWith<_$ReportPostRequestImpl> get copyWith =>
      __$$ReportPostRequestImplCopyWithImpl<_$ReportPostRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportPostRequestImplToJson(
      this,
    );
  }
}

abstract class _ReportPostRequest implements ReportPostRequest {
  const factory _ReportPostRequest(
      {final int? writerId,
      final String? postId,
      final String? commentId,
      final int? reasonTypeIndex,
      final String? detailReason}) = _$ReportPostRequestImpl;

  factory _ReportPostRequest.fromJson(Map<String, dynamic> json) =
      _$ReportPostRequestImpl.fromJson;

  @override
  int? get writerId;
  @override
  String? get postId;
  @override
  String? get commentId;
  @override
  int? get reasonTypeIndex;
  @override
  String? get detailReason;

  /// Create a copy of ReportPostRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportPostRequestImplCopyWith<_$ReportPostRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
