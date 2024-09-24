import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/app_bloc_observer.dart';
import 'package:flutter_whattodayrice/common/const/supa_base_env.dart';
import 'package:flutter_whattodayrice/common/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_whattodayrice/router/route_config.dart';
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
    url: supabaseEnv.projectURL,
    anonKey: supabaseEnv.projectApiKey,
  );

  KakaoSdk.init(
    nativeAppKey: supabaseEnv.kaKaoClientId,
    javaScriptAppKey: supabaseEnv.kaKaoJsClientId,
  );

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          builder: (theme, darkTheme) => MaterialApp.router(
            theme: theme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: routerConfig,
          ),
        );
      },
    );
  }
}
