import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/common/utils/user_access_date_page_index.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';

final initialPageIndexProvider = StateProvider(
  (ref) {
    DormitoryType dormitoryType = ref.watch(dormitoryProvider);
    DateTime userAccessTime = DateTime.now();
    int initialPageIndex =
        getUserAccessDatePageIndex(userAccessTime, dormitoryType);
    return initialPageIndex;
  },
);
