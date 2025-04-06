import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  @JsonSerializable()
  const factory Profile({
    required int id,
    required String nickname,
    @Default([]) List<BlockedUserProfile> blockedUsers,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}

@freezed
class BlockedUserProfile with _$BlockedUserProfile {
  @JsonSerializable()
  const factory BlockedUserProfile({
    required int id,
    required String? nickname,
  }) = _BlockedUserProfile;

  factory BlockedUserProfile.fromJson(Map<String, dynamic> json) => _$BlockedUserProfileFromJson(json);
}
