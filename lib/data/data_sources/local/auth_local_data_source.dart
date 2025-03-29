import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class AuthLocalDataSource {
  final _accessTokenKey = 'accessToken';

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_accessTokenKey);
  }

  Future<void> setAccessToken(String oauthToken) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(_accessTokenKey, oauthToken);
  }

  Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(_accessTokenKey);
  }
}
