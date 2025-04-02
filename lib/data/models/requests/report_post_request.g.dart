// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportPostRequestImpl _$$ReportPostRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ReportPostRequestImpl(
      writerId: (json['writer_id'] as num?)?.toInt(),
      postId: json['post_id'] as String?,
      commentId: json['comment_id'] as String?,
      reasonTypeIndex: (json['reason_type_index'] as num?)?.toInt(),
      detailReason: json['detail_reason'] as String?,
    );

Map<String, dynamic> _$$ReportPostRequestImplToJson(
        _$ReportPostRequestImpl instance) =>
    <String, dynamic>{
      'writer_id': instance.writerId,
      'post_id': instance.postId,
      'comment_id': instance.commentId,
      'reason_type_index': instance.reasonTypeIndex,
      'detail_reason': instance.detailReason,
    };
