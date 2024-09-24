import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/dormitory/dormitory_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/register/register_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/setting/setting_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/sign_in_by_email/sign_in_by_email_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/splash/splash_bloc.dart';
import 'package:flutter_whattodayrice/data/data_source/auth_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/data_source/happy_meal_data_source.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/impl/auth_repository_impl.dart';
import 'package:flutter_whattodayrice/data/repository/meal_repository.dart';
import 'package:flutter_whattodayrice/data/services/happy_meal_service.dart';
import 'package:flutter_whattodayrice/data/services/supabase_service.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_register_email.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_login_info.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_home.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_setting.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_sign_in_by_email.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_splash.dart';
import 'package:flutter_whattodayrice/router/app_router_state.dart';
import 'package:go_router/go_router.dart';

final AuthRepository _authRepository = AuthRepositoryImpl(
  authRemoteDataSource: AuthRemoteDataSource(supabaseService: SupabaseService.instance),
);

final DormitoryMealRepository _dormitoryMealRepository = DormitoryMealRepository(
  happyDormsMealRemoteDataSource: HappyDormsMealRemoteDataSource(happyMealService: HappyMealService()),
);

final routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/login-callback', redirect: (context, state) => '/'),
    GoRoute(
      path: '/splash',
      builder: (context, state) => BlocProvider(
        create: (context) => SplashBloc(authRepository: _authRepository),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/login-info',
      name: AppRouteState.loginInfo.name,
      builder: (context, state) => BlocProvider(
        create: (context) => RegisterBloc(authRepository: _authRepository),
        child: const LoginInfoScreen(),
      ),
      routes: [
        GoRoute(
          path: 'email-register',
          name: AppRouteState.emailRegister.name,
          builder: (context, state) => BlocProvider(
            create: (context) => RegisterBloc(authRepository: _authRepository),
            child: const RegisterEmailScreen(),
          ),
        ),
        GoRoute(
          path: 'sign-in-by-email',
          name: AppRouteState.signIn.name,
          builder: (context, state) => BlocProvider(
            create: (context) => SignInByEmailBloc(authRepository: _authRepository),
            child: const SignInByEmailScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      name: AppRouteState.home.name,
      builder: (context, state) => BlocProvider(
        create: (context) => DormitoryBloc(dormitoryMealRepository: _dormitoryMealRepository),
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          path: 'setting',
          name: AppRouteState.setting.name,
          builder: (context, state) => BlocProvider(
            create: (context) => SettingBloc(authRepository: _authRepository),
            child: const SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
);
