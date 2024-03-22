import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/presentation/m_page_controller.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';
import 'package:flutter_whattodayrice/presentation/providers/meal/meal_data_provider.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_grow_transition.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_menu_fragment.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_splash_logo.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/settings_screen.dart';
import '../../../data/models/dormitory.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final DormitoryType dormitoryType;
  const HomeScreen({super.key, required this.dormitoryType});

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
    final pageNavigationState = ref.watch(pageNavigationStateProvider);
    final AsyncValue<List<MealData>> weeklyMeals = ref.watch(mealDataProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.primary,
        centerTitle: true,
        title: Text(
          (selectedDormitory == DormitoryType.sejong1 ||
                  selectedDormitory == DormitoryType.sejong2)
              ? "세종기숙사"
              : "행복기숙사",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: weeklyMeals.when(
        data: (data) {
          return PageView.builder(
            controller: pageNavigationState.pageController,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return MenuFragment(
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
        error: (object, stackTrace) => Center(
          child: Text('Error: $object'),
        ),
      ),
    );
  }
}
