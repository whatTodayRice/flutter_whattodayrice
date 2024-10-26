import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/register/register_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/setting/setting_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/sign_in_by_email/sign_in_by_email_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/splash/splash_bloc.dart';
import 'package:flutter_whattodayrice/common/utils/event_bus.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_post_type.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/meal_repository.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/modules/board/bloc/post_bloc.dart';
import 'package:flutter_whattodayrice/modules/board/board_screen.dart';
import 'package:flutter_whattodayrice/modules/board/comment/bloc/comment_bloc.dart';
import 'package:flutter_whattodayrice/modules/board/post_creation/bloc/post_creation_bloc.dart';
import 'package:flutter_whattodayrice/modules/board/post_creation/post_creation_screen.dart';
import 'package:flutter_whattodayrice/modules/board/post_detail_screen.dart';
import 'package:flutter_whattodayrice/modules/home/bloc/home_bloc.dart';
import 'package:flutter_whattodayrice/modules/home/s_home.dart';
import 'package:flutter_whattodayrice/modules/meal/bloc/dormitory_meal_bloc.dart';
import 'package:flutter_whattodayrice/modules/meal/meal_screen.dart';
import 'package:flutter_whattodayrice/modules/second-hand/second_hand_screen.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_register_email.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_setting.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_sign_in_by_email.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_splash.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_login_info.dart';

import 'package:go_router/go_router.dart';

part 'app_router_state.dart';

final AuthRepository _authRepository = getIt<AuthRepository>();
final DormitoryMealRepository _dormitoryMealRepository = getIt<DormitoryMealRepository>();

final routerConfig = GoRouter(
  initialLocation: '/${AppRouteState.splash.path}',
  routes: [
    GoRoute(
      path: '/${AppRouteState.splash.path}',
      builder: (context, state) => BlocProvider(
        create: (context) => SplashBloc(authRepository: _authRepository),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/${AppRouteState.loginInfo.path}',
      name: AppRouteState.loginInfo.name,
      builder: (context, state) => BlocProvider(
        create: (context) => RegisterBloc(authRepository: _authRepository),
        child: const LoginInfoScreen(),
      ),
      routes: [
        GoRoute(
          path: AppRouteState.emailRegister.path,
          name: AppRouteState.emailRegister.name,
          builder: (context, state) => BlocProvider(
            create: (context) => RegisterBloc(authRepository: _authRepository),
            child: const RegisterEmailScreen(),
          ),
        ),
        GoRoute(
          path: AppRouteState.signIn.path,
          name: AppRouteState.signIn.name,
          builder: (context, state) => BlocProvider(
            create: (context) => SignInByEmailBloc(authRepository: _authRepository),
            child: const SignInByEmailScreen(),
          ),
        ),
      ],
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
              path: "/${AppRouteState.board.path}",
              name: AppRouteState.board.name,
              builder: (context, state) => BlocProvider(
                create: (context) => PostBloc(
                  postRepository: getIt<PostRepository>(),
                  eventBus: getIt<EventBus>(),
                ),
                child: const BoardScreen(),
              ),
              routes: [
                GoRoute(
                  path: AppRouteState.postCreation.path,
                  name: AppRouteState.postCreation.name,
                  builder: (context, state) {
                    final PostType extra = state.extra as PostType;

                    return BlocProvider(
                      create: (context) => PostCreationBloc(
                        authRepository: _authRepository,
                        postRepository: getIt<PostRepository>(),
                        postType: extra,
                      ),
                      child: PostCreationScreen(postType: extra),
                    );
                  },
                ),
                GoRoute(
                  path: AppRouteState.postDetail.path,
                  name: AppRouteState.postDetail.name,
                  builder: (context, state) {
                    final post = state.extra as Post;

                    return BlocProvider(
                      create: (context) => CommentBloc(
                        postRepository: getIt<PostRepository>(),
                        authRepository: getIt<AuthRepository>(),
                        postId: post.postId,
                      ),
                      child: PostDetailScreen(post: post),
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
              path: "/${AppRouteState.secondHand.path}",
              name: AppRouteState.secondHand.name,
              builder: (context, state) => const SecondHandScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
