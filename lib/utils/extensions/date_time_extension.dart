extension DateTimeX on DateTime? {
  String getRelativeDateFormat() {
    if (this == null) {
      return "-";
    }

    final now = DateTime.now();
    final difference = now.difference(this!);

    if (difference.inSeconds < 60) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 8) {
      return '${difference.inDays}일 전';
    }

    return "-";
  }
}
