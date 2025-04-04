import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:go_router/go_router.dart';

abstract class LoginValidator {
  static bool? isUserLoggedIn() => getIt<UserRepository>().getUserProfileFromCache() != null;

  static Future<bool?> validate(BuildContext context) async {
    final goRouter = GoRouter.of(context);

    return await goRouter.pushNamed<bool?>(AppRouteState.signIn.name);
  }
}
