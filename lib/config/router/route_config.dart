import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/common/widget/app_modal_route.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:flutter_whattodayrice/modules/second-hand/bloc/second_hand_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/create_post_screen.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/bloc/post_detail_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/post_detail_screen.dart';
import 'package:flutter_whattodayrice/modules/second-hand/report/bloc/report_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/report/report_screen.dart';
import 'package:flutter_whattodayrice/modules/setting/my_posts/bloc/my_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/setting/my_posts/my_post_screen.dart';
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

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerConfig = GoRouter(
  initialLocation: '/${AppRouteState.splash.path}',
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/${AppRouteState.splash.path}',
      builder: (context, state) => BlocProvider(
        create: (context) =>
            SplashBloc(authRepository: getIt<AuthRepository>(), userRepository: getIt<UserRepository>()),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/${AppRouteState.signIn.path}',
      name: AppRouteState.signIn.name,
      pageBuilder: (context, state) => AppModalRoutePage(
        child: BlocProvider(
          create: (context) =>
              SignInBloc(authRepository: getIt<AuthRepository>(), userRepository: getIt<UserRepository>()),
          child: const SignInScreen(),
        ),
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
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: AppRouteState.postDetail.path,
                  name: AppRouteState.postDetail.name,
                  builder: (context, state) {
                    final postId = state.pathParameters['id'];

                    if (postId == null) {
                      throw Exception('Not Founded PostId Exception');
                    }

                    return BlocProvider(
                      create: (state) => PostDetailBloc(
                        postRepository: getIt<PostRepository>(),
                        userRepository: getIt<UserRepository>(),
                      ),
                      child: PostDetailScreen(postId: state.pathParameters['id'] ?? ''),
                    );
                  },
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: AppRouteState.report.path,
                  name: AppRouteState.report.name,
                  builder: (context, state) {
                    final postId = state.uri.queryParameters['postId'];

                    if (postId == null) {
                      throw Exception('존재하지 않는 게시글입니다.');
                    }

                    final commentId = state.uri.queryParameters['commentId'];

                    return BlocProvider(
                      create: (state) => ReportBloc(
                        postRepository: getIt<PostRepository>(),
                        userRepository: getIt<UserRepository>(),
                        postId: postId,
                        commentId: commentId,
                      ),
                      child: const ReportScreen(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/${AppRouteState.meal.path}",
              name: AppRouteState.meal.name,
              builder: (context, state) => BlocProvider(
                create: (context) => DormitoryMealBloc(dormitoryMealRepository: getIt<DormitoryMealRepository>()),
                child: const MealScreen(),
              ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: AppRouteState.setting.path,
                  name: AppRouteState.setting.name,
                  builder: (context, state) => BlocProvider(
                    create: (context) => SettingBloc(
                      userRepository: getIt<UserRepository>(),
                      authRepository: getIt<AuthRepository>(),
                    ),
                    child: const SettingsScreen(),
                  ),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: AppRouteState.myPosts.path,
                      name: AppRouteState.myPosts.name,
                      builder: (context, state) => BlocProvider(
                        create: (context) => MyPostBloc(
                          postRepository: getIt<PostRepository>(),
                          userRepository: getIt<UserRepository>(),
                        ),
                        child: const MyPostScreen(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
