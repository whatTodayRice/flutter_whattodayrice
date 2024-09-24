import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_data.freezed.dart';
part 'auth_data.g.dart';

@freezed
class AuthData with _$AuthData {
  @JsonSerializable()
  const factory AuthData({
    required String accessToken,
    required String refreshToken,
  }) = _AuthData;

  factory AuthData.fromJson(Map<String, Object?> json) => _$AuthDataFromJson(json);
}
