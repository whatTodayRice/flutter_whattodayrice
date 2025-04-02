import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_request.freezed.dart';
part 'create_post_request.g.dart';

@freezed
class CreatePostRequest with _$CreatePostRequest {
  const factory CreatePostRequest({
    String? id,
    int? userId,
    String? nickname,
    String? title,
    String? content,
    int? price,
    String? location,
    String? imageUrl,
    int? sellStatus,
    String? parentPostId,
  }) = _CreatePostRequest;

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) => _$CreatePostRequestFromJson(json);
}
