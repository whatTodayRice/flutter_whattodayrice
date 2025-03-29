import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/config/kakao_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/utils/log/app_bloc_observer.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TODO: 추후 제거 필요
  // final supabaseEnv = SuPaBaseEnv.instance;
  //
  // await Supabase.initialize(
  //   url: supabaseEnv.projectURL,
  //   anonKey: supabaseEnv.projectApiKey,
  // );

  KakaoSdk.init(
    nativeAppKey: KakaoConfig.nativeAppKey,
    javaScriptAppKey: KakaoConfig.javascriptAppKey,
  );

  Bloc.observer = AppBlocObserver();

  configureDependencies();

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
          light: AppTheme.lightTheme,
          dark: AppTheme.dartTheme,
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
