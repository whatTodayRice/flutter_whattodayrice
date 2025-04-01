import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:flutter_whattodayrice/modules/second-hand/bloc/second_hand_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/create_post_screen.dart';
import 'package:flutter_whattodayrice/modules/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter_whattodayrice/modules/setting/bloc/setting_bloc.dart';
import 'package:flutter_whattodayrice/modules/splash/bloc/splash_bloc.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/meal_repository.dart';
import 'package:flutter_whattodayrice/modules/home/bloc/home_bloc.dart';
import 'package:flutter_whattodayrice/modules/home/s_home.dart';
import 'package:flutter_whattodayrice/modules/meal/bloc/dormitory_meal_bloc.dart';
import 'package:flutter_whattodayrice/modules/meal/meal_screen.dart';
import 'package:flutter_whattodayrice/modules/second-hand/second_hand_screen.dart';
import 'package:flutter_whattodayrice/modules/setting/s_setting.dart';
import 'package:flutter_whattodayrice/modules/splash/s_splash.dart';
import 'package:flutter_whattodayrice/modules/sign_in/sign_in_screen.dart';

import 'package:go_router/go_router.dart';

part 'app_router_state.dart';

final AuthRepository _authRepository = getIt<AuthRepository>();
final DormitoryMealRepository _dormitoryMealRepository = getIt<DormitoryMealRepository>();

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerConfig = GoRouter(
  initialLocation: '/${AppRouteState.splash.path}',
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/${AppRouteState.splash.path}',
      builder: (context, state) => BlocProvider(
        create: (context) => SplashBloc(authRepository: _authRepository, userRepository: getIt<UserRepository>()),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/${AppRouteState.signIn.path}',
      name: AppRouteState.signIn.name,
      builder: (context, state) => BlocProvider(
        create: (context) => SignInBloc(
          authRepository: _authRepository,
          userRepository: getIt<UserRepository>(),
        ),
        child: const SignInScreen(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => BlocProvider(
        create: (context) => HomeBloc(),
        child: HomeScreen(navigationShell: navigationShell),
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/${AppRouteState.meal.path}",
              name: AppRouteState.meal.name,
              builder: (context, state) => BlocProvider(
                create: (context) => DormitoryMealBloc(dormitoryMealRepository: _dormitoryMealRepository),
                child: const MealScreen(),
              ),
              routes: [
                GoRoute(
                  path: AppRouteState.setting.path,
                  name: AppRouteState.setting.name,
                  builder: (context, state) => BlocProvider(
                    create: (context) => SettingBloc(authRepository: _authRepository),
                    child: const SettingsScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/${AppRouteState.secondHand.path}",
              name: AppRouteState.secondHand.name,
              builder: (context, state) => BlocProvider(
                create: (context) => SecondHandBloc(postRepository: getIt<PostRepository>()),
                child: const SecondHandScreen(),
              ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: AppRouteState.createPost.path,
                  name: AppRouteState.createPost.name,
                  builder: (context, state) => BlocProvider(
                    create: (state) => CreatePostBloc(
                      postRepository: getIt<PostRepository>(),
                      userRepository: getIt<UserRepository>(),
                    ),
                    child: const CreatePostScreen(),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
