import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/dormitory/dormitory_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/splash/splash_bloc.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_grow_transition.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_menu_fragment.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_splash_logo.dart';
import 'package:flutter_whattodayrice/presentation/view/screens/s_setting.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final routeName = "/${AppRouteState.home.name}";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, AfterLayoutMixin<HomeScreen> {
  late final AnimationController controller;
  late final PageController pageController;

  @override
  void afterFirstLayout(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    final loggedInDayIndex = DateTime.now().toUtc().add(const Duration(hours: 9)).weekday;
    pageController = PageController(initialPage: loggedInDayIndex);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    context.read<DormitoryBloc>().add(const DormitoryMealLoadRequested());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.primary,
        centerTitle: true,
        title: Text("행복기숙사", style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: BlocBuilder(
        builder: (context, state) {
          if (state is! DormitoryMealLoaded) {
            Animation<double> animation = Tween<double>(begin: 0, end: 1).animate(controller);
            controller.repeat();
            return GrowTransition(
              animation: animation,
              child: const SplashLogo(
                animatedValue: 1.0,
              ),
            );
          }

          final List<MealData> mealDataList = state.mealDataList;

          return PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: mealDataList.length,
            itemBuilder: (context, index) {
              final MealData mealData = mealDataList[index];

              return MenuFragment(mealData: mealData);
            },
          );
        },
      ),
    );
  }
}
