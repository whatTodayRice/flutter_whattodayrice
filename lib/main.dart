import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/presentation/providers/dto_user_info.dart';
import 'package:flutter_whattodayrice/common/theme/text_theme.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/home_screen.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_select_dormitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.remove('dormitory');
  // prefs.remove('userId');

  final storedUserID = await readUserIdSharedPreferencesData();
  final isIDInFirestore = await isIDInFireStore(storedUserID);

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: MyApp(
        isIDInFirestore: isIDInFirestore,
      )));
}

class MyApp extends ConsumerWidget {
  final bool isIDInFirestore;
  const MyApp({super.key, required this.isIDInFirestore});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeighth = MediaQuery.of(context).size.height;
    DormitoryType userDormitoryType = ref.read(dormitoryProvider);

    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeighth),
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
              routes: {
                SettingsScreen.routeName: (context) => const SettingsScreen(),
              },
              debugShowCheckedModeBanner: false,
              home: child),
        );
      },
      child: isIDInFirestore
          ? HomeScreen(dormitoryType: userDormitoryType)
          : const SelectDormitoryScreen(),
    );
  }
}
