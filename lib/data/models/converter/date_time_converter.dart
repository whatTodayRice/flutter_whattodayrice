import 'package:flutter_whattodayrice/utils/extensions/date_time_converter.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<String, String> {
  const TimestampConverter();

  @override
  String fromJson(String timestamp) {
    return formatCreatedAt(timestamp);
  }

  @override
  String toJson(String formattedDate) => formattedDate;
}
