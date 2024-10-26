import 'package:intl/intl.dart';

/// timeStamp 형식을 시간 표기 정책에 맞춰서
/// Date Format을 변환하는 함수

String formatCreatedAt(String createdAtString) {
  DateTime createdAt = DateTime.parse(createdAtString).toLocal();
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inSeconds < 60) {
    return '방금 전';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}분 전';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}시간 전';
  } else if (difference.inDays < 8) {
    return '${difference.inDays}일 전';
  } else {
    return DateFormat('yyyy. M. d').format(createdAt);
  }
}
