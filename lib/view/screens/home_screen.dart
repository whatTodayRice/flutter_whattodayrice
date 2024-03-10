import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_whattodayrice/models/m_page_controller.dart';
import 'package:flutter_whattodayrice/theme/colors.dart';
import 'package:flutter_whattodayrice/view/components/w_grow_transition.dart';
import 'package:flutter_whattodayrice/view/components/w_menu_fragment.dart';
import 'package:flutter_whattodayrice/view/components/w_splash_logo.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';
import '../../models/dormitory.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/providers/meal_data_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<HomeScreen> {
  late final AnimationController controller;

  @override
  void afterFirstLayout(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    // updateDormitoryMeal(dormitoryType!);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDormitory = ref.watch(dormitoryProvider);
    final weeklyMealsAsyncValue = ref.watch(mealDataProvider);
    final pageNavigationState = ref.watch(pageNavigationStateProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.primary,
        title: Text(
            (selectedDormitory == DormitoryType.sejong1 ||
                    selectedDormitory == DormitoryType.sejong2)
                ? "세종기숙사"
                : "행복기숙사",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: weeklyMealsAsyncValue.when(
        data: (weeklyMeals) {
          return PageView.builder(
            controller: pageNavigationState.pageController,
            scrollDirection: Axis.horizontal,
            itemCount: weeklyMeals.length,
            itemBuilder: (context, index) {
              var meal = weeklyMeals[index];
              String dateString = weeklyMeals.first!.date;
              DateTime firstDate = DateTime.parse(dateString);

              return MenuFragment(
                meal: meal,
                date: firstDate,
                index: index,
              );
            },
          );
        },
        loading: () {
          Animation<double> animation =
              Tween<double>(begin: 0, end: 1).animate(controller);

          controller.repeat();

          return GrowTransition(
            animation: animation,
            child: const SplashLogo(
              animatedValue: 1.0,
            ),
          );
        },
        error: (error, stackTrace) {
          // 에러 처리
          return Center(
            child: Text('Error: $error'),
          );
        },
      ),
    );
  }
}
