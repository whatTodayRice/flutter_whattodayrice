import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_post_request.freezed.dart';
part 'report_post_request.g.dart';

@freezed
class ReportPostRequest with _$ReportPostRequest {
  const factory ReportPostRequest({
    int? writerId,
    String? postId,
    String? commentId,
    int? reasonTypeIndex,
    String? detailReason,
  }) = _ReportPostRequest;

  factory ReportPostRequest.fromJson(Map<String, dynamic> json) => _$ReportPostRequestFromJson(json);
}
