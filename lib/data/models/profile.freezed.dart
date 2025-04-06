// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  int get id => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  List<BlockedUserProfile> get blockedUsers =>
      throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call({int id, String nickname, List<BlockedUserProfile> blockedUsers});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? blockedUsers = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      blockedUsers: null == blockedUsers
          ? _value.blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<BlockedUserProfile>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String nickname, List<BlockedUserProfile> blockedUsers});
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? blockedUsers = null,
  }) {
    return _then(_$ProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      blockedUsers: null == blockedUsers
          ? _value._blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<BlockedUserProfile>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl(
      {required this.id,
      required this.nickname,
      final List<BlockedUserProfile> blockedUsers = const []})
      : _blockedUsers = blockedUsers;

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final int id;
  @override
  final String nickname;
  final List<BlockedUserProfile> _blockedUsers;
  @override
  @JsonKey()
  List<BlockedUserProfile> get blockedUsers {
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUsers);
  }

  @override
  String toString() {
    return 'Profile(id: $id, nickname: $nickname, blockedUsers: $blockedUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            const DeepCollectionEquality()
                .equals(other._blockedUsers, _blockedUsers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nickname,
      const DeepCollectionEquality().hash(_blockedUsers));

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {required final int id,
      required final String nickname,
      final List<BlockedUserProfile> blockedUsers}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  int get id;
  @override
  String get nickname;
  @override
  List<BlockedUserProfile> get blockedUsers;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BlockedUserProfile _$BlockedUserProfileFromJson(Map<String, dynamic> json) {
  return _BlockedUserProfile.fromJson(json);
}

/// @nodoc
mixin _$BlockedUserProfile {
  int get id => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;

  /// Serializes this BlockedUserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlockedUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlockedUserProfileCopyWith<BlockedUserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockedUserProfileCopyWith<$Res> {
  factory $BlockedUserProfileCopyWith(
          BlockedUserProfile value, $Res Function(BlockedUserProfile) then) =
      _$BlockedUserProfileCopyWithImpl<$Res, BlockedUserProfile>;
  @useResult
  $Res call({int id, String? nickname});
}

/// @nodoc
class _$BlockedUserProfileCopyWithImpl<$Res, $Val extends BlockedUserProfile>
    implements $BlockedUserProfileCopyWith<$Res> {
  _$BlockedUserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlockedUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlockedUserProfileImplCopyWith<$Res>
    implements $BlockedUserProfileCopyWith<$Res> {
  factory _$$BlockedUserProfileImplCopyWith(_$BlockedUserProfileImpl value,
          $Res Function(_$BlockedUserProfileImpl) then) =
      __$$BlockedUserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? nickname});
}

/// @nodoc
class __$$BlockedUserProfileImplCopyWithImpl<$Res>
    extends _$BlockedUserProfileCopyWithImpl<$Res, _$BlockedUserProfileImpl>
    implements _$$BlockedUserProfileImplCopyWith<$Res> {
  __$$BlockedUserProfileImplCopyWithImpl(_$BlockedUserProfileImpl _value,
      $Res Function(_$BlockedUserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of BlockedUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = freezed,
  }) {
    return _then(_$BlockedUserProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$BlockedUserProfileImpl implements _BlockedUserProfile {
  const _$BlockedUserProfileImpl({required this.id, required this.nickname});

  factory _$BlockedUserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockedUserProfileImplFromJson(json);

  @override
  final int id;
  @override
  final String? nickname;

  @override
  String toString() {
    return 'BlockedUserProfile(id: $id, nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockedUserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nickname);

  /// Create a copy of BlockedUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockedUserProfileImplCopyWith<_$BlockedUserProfileImpl> get copyWith =>
      __$$BlockedUserProfileImplCopyWithImpl<_$BlockedUserProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockedUserProfileImplToJson(
      this,
    );
  }
}

abstract class _BlockedUserProfile implements BlockedUserProfile {
  const factory _BlockedUserProfile(
      {required final int id,
      required final String? nickname}) = _$BlockedUserProfileImpl;

  factory _BlockedUserProfile.fromJson(Map<String, dynamic> json) =
      _$BlockedUserProfileImpl.fromJson;

  @override
  int get id;
  @override
  String? get nickname;

  /// Create a copy of BlockedUserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlockedUserProfileImplCopyWith<_$BlockedUserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
