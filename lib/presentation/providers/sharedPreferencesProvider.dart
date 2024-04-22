import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/data/models/m_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

class SharedPreferencesService {
  Future<void> saveDormitorySharedPreferences(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  final userIdProvider = StateProvider((ref) {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    return sharedPreferences.getString('userId');
  });

  Future<void> saveUserId(String userId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userId', userId);
  }
}
