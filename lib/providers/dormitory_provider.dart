import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';

final dormitoryProvider = StateProvider(
  (ref) => DormitoryType.happiness,
);
