import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/view/screens/home_screen.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';
import 'package:flutter_whattodayrice/services/fetch_sejong_meals.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // databaseFactory = databaseFactoryFfi;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
        ),
      ),
      dark: ThemeData(
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
        home: const Scaffold(body: HomeScreen()),
      ),
    );
  }
}
