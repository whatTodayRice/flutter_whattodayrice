// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String? get id => throw _privateConstructorUsedError;
  String? get parentPostId => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get sellStatus => throw _privateConstructorUsedError;
  List<Post> get comments => throw _privateConstructorUsedError;

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String? id,
      String? parentPostId,
      int? userId,
      String? nickname,
      String? title,
      String? content,
      String? imageUrl,
      int? price,
      String? location,
      DateTime? createdAt,
      int? sellStatus,
      List<Post> comments});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? parentPostId = freezed,
    Object? userId = freezed,
    Object? nickname = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? imageUrl = freezed,
    Object? price = freezed,
    Object? location = freezed,
    Object? createdAt = freezed,
    Object? sellStatus = freezed,
    Object? comments = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      parentPostId: freezed == parentPostId
          ? _value.parentPostId
          : parentPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sellStatus: freezed == sellStatus
          ? _value.sellStatus
          : sellStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? parentPostId,
      int? userId,
      String? nickname,
      String? title,
      String? content,
      String? imageUrl,
      int? price,
      String? location,
      DateTime? createdAt,
      int? sellStatus,
      List<Post> comments});
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? parentPostId = freezed,
    Object? userId = freezed,
    Object? nickname = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? imageUrl = freezed,
    Object? price = freezed,
    Object? location = freezed,
    Object? createdAt = freezed,
    Object? sellStatus = freezed,
    Object? comments = null,
  }) {
    return _then(_$PostImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      parentPostId: freezed == parentPostId
          ? _value.parentPostId
          : parentPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sellStatus: freezed == sellStatus
          ? _value.sellStatus
          : sellStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  const _$PostImpl(
      {this.id,
      this.parentPostId,
      this.userId,
      this.nickname,
      this.title,
      this.content,
      this.imageUrl,
      this.price,
      this.location,
      this.createdAt,
      this.sellStatus,
      final List<Post> comments = const []})
      : _comments = comments;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final String? id;
  @override
  final String? parentPostId;
  @override
  final int? userId;
  @override
  final String? nickname;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? imageUrl;
  @override
  final int? price;
  @override
  final String? location;
  @override
  final DateTime? createdAt;
  @override
  final int? sellStatus;
  final List<Post> _comments;
  @override
  @JsonKey()
  List<Post> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString() {
    return 'Post(id: $id, parentPostId: $parentPostId, userId: $userId, nickname: $nickname, title: $title, content: $content, imageUrl: $imageUrl, price: $price, location: $location, createdAt: $createdAt, sellStatus: $sellStatus, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentPostId, parentPostId) ||
                other.parentPostId == parentPostId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sellStatus, sellStatus) ||
                other.sellStatus == sellStatus) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      parentPostId,
      userId,
      nickname,
      title,
      content,
      imageUrl,
      price,
      location,
      createdAt,
      sellStatus,
      const DeepCollectionEquality().hash(_comments));

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
      {final String? id,
      final String? parentPostId,
      final int? userId,
      final String? nickname,
      final String? title,
      final String? content,
      final String? imageUrl,
      final int? price,
      final String? location,
      final DateTime? createdAt,
      final int? sellStatus,
      final List<Post> comments}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  String? get id;
  @override
  String? get parentPostId;
  @override
  int? get userId;
  @override
  String? get nickname;
  @override
  String? get title;
  @override
  String? get content;
  @override
  String? get imageUrl;
  @override
  int? get price;
  @override
  String? get location;
  @override
  DateTime? get createdAt;
  @override
  int? get sellStatus;
  @override
  List<Post> get comments;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
