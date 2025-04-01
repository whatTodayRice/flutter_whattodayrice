import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_request.freezed.dart';
part 'create_post_request.g.dart';

@freezed
class CreatePostRequest with _$CreatePostRequest {
  const factory CreatePostRequest({
    required int userId,
    required String nickname,
    required String title,
    int? price,
    required bool isShared,
    required String location,
    String? imageUrl,
  }) = _CreatePostRequest;

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) => _$CreatePostRequestFromJson(json);
}
