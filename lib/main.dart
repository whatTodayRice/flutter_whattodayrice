import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/dormitory/dormitory_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/register/register_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/sign_in_by_email/sign_in_by_email_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/splash/splash_bloc.dart';
import 'package:flutter_whattodayrice/common/const/supa_base_env.dart';
import 'package:flutter_whattodayrice/data/data_source/auth_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/data_source/happy_meal_data_source.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/impl/auth_repository_impl.dart';
import 'package:flutter_whattodayrice/data/repository/meal_repository.dart';
import 'package:flutter_whattodayrice/data/services/happy_meal_service.dart';
import 'package:flutter_whattodayrice/common/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/data/services/supabase_service.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_home.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_sign_in_by_email.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_splash.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/register/s_user_register.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final supabaseEnv = SuPaBaseEnv.instance;
  await Supabase.initialize(
    url: supabaseEnv.getProjURL(),
    anonKey: supabaseEnv.getProjApiKey(),
  );

  KakaoSdk.init(
    nativeAppKey: supabaseEnv.getKAKAOClientId(),
    javaScriptAppKey: supabaseEnv.getKAKAOJsClientId(),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();

    _authRepository = AuthRepositoryImpl(
      authRemoteDataSource: AuthRemoteDataSource(supabaseService: SupabaseService.instance),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return AdaptiveTheme(
          light: ThemeData(
            brightness: Brightness.light,
            textTheme: Themes.lightTextTheme,
          ),
          dark: ThemeData(
            brightness: Brightness.dark,
            textTheme: Themes.darkTextTheme,
          ),
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) => MaterialApp(
            theme: theme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            routes: {
              SettingsScreen.routeName: (context) => const SettingsScreen(),
              UserRegisterScreen.routeName: (context) => BlocProvider(
                    create: (context) => RegisterBloc(authRepository: _authRepository),
                    child: const UserRegisterScreen(),
                  ),
              SplashScreen.routeName: (context) => BlocProvider(
                    create: (context) => SplashBloc(authRepository: _authRepository),
                    child: const SplashScreen(),
                  ),
              SignInByEmailScreen.routeName: (context) => BlocProvider(
                    create: (context) => SignInByEmailBloc(
                      authRepository: _authRepository,
                    ),
                    child: const SignInByEmailScreen(),
                  ),
              HomeScreen.routeName: (context) => BlocProvider(
                    create: (context) => DormitoryBloc(
                      dormitoryMealRepository: DormitoryMealRepository(
                        happyDormsMealRemoteDataSource: HappyDormsMealRemoteDataSource(
                          happyMealService: HappyMealService(),
                        ),
                      ),
                    ),
                    child: const HomeScreen(),
                  ),
            },
            initialRoute: UserRegisterScreen.routeName,
          ),
        );
      },
    );
  }
}

class Config {
  final String baseUrl;
  final String token;

  Config._dev()
      : baseUrl = '',
        token = '';

  Config._product()
      : baseUrl = '',
        token = '';

  static late final Config instance;

  factory Config(String? flavor) {
    if (flavor == 'dev') {
      instance = Config._dev();
    } else if (flavor == 'product') {
      instance = Config._product();
    } else {
      throw Exception('Unknown flavor : $flavor');
    }

    return instance;
  }
}
