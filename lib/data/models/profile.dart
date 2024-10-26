import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  @JsonSerializable()
  const factory Profile({
    required String id,
    required String nickname,
  }) = _Profile;
  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}
