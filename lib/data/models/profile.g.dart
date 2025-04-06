// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
      blockedUsers: (json['blocked_users'] as List<dynamic>?)
              ?.map(
                  (e) => BlockedUserProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'blocked_users': instance.blockedUsers,
    };

_$BlockedUserProfileImpl _$$BlockedUserProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$BlockedUserProfileImpl(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$$BlockedUserProfileImplToJson(
        _$BlockedUserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
    };
