import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_whattodayrice/providers/dto_user_info.dart';
import 'package:flutter_whattodayrice/view/screens/home_screen.dart';
import 'package:flutter_whattodayrice/view/screens/s_select_dormitory.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:shared_preferences/shared_preferences.dart';

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

class MyApp extends StatelessWidget {
  final bool isIDInFirestore;
  const MyApp({Key? key, required this.isIDInFirestore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          headlineMedium:
              GoogleFonts.notoSans(fontSize: 18, fontWeight: FontWeight.bold),
          titleMedium:
              GoogleFonts.notoSans(fontSize: 20, fontWeight: FontWeight.w700),
          titleSmall:
              GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w700),
          bodyMedium: GoogleFonts.notoSans(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          bodySmall: GoogleFonts.notoSans(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.notoSans(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          titleMedium: GoogleFonts.notoSans(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          titleSmall: GoogleFonts.notoSans(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          bodyMedium: GoogleFonts.notoSans(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          bodySmall: GoogleFonts.notoSans(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        routes: {
          SettingsScreen.routeName: (context) => const SettingsScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: isIDInFirestore
            ? const HomeScreen()
            : const SelectDormitoryScreen(),
      ),
    );
  }
}
