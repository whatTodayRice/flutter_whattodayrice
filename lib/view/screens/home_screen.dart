import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_whattodayrice/services/fetch_meals_on_dorms.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/view/components/w_grow_transition.dart';
import 'package:flutter_whattodayrice/view/components/w_splash_logo.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';
import 'package:intl/intl.dart';
import '../../models/dormitory.dart';
import '../../models/meal.dart';
import '../../services/fetch_happy_meals.dart';
import '../../services/fetch_sejong_meals.dart';
import '../components/meal_container.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController controller;
  late Future<List<MealData>> futureMealData;

  List<MealData> weeklyMeals = [];
  DormitoryType dormitoryType = DormitoryType.happiness;

  // List<MealData> updateDormitoryMeal(DormitoryType dormitoryType) {
  //   fetchMealDataFromDB(dormitoryType).then((newData) {
  //     if (mounted) {
  //       return weeklyMeals = newData;
  //     }
  //   }).catchError((error) {
  //     // 에러 처리
  //     print('Error fetching meal data: $error');
  //     if (mounted) {
  //       weeklyMeals = [];
  //     }
  //   });
  // }

  @override
  void afterFirstLayout(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    FlutterNativeSplash.remove();
  }

  DateTime monday = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - 1)); // 월요일부터로 조정

  DateTime sunday = DateTime.now()
      .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday));

  DateTime selectedDate = DateTime.now();

  void onDaySelected(DateTime selectedDay) {
    int selectedDayWeekday = selectedDay.weekday;
    DateTime monday =
        selectedDay.subtract(Duration(days: selectedDayWeekday - 1));

    setState(() {
      selectedDate = selectedDay;
    });

    int differenceInDays = selectedDay.difference(monday).inDays;

    if (differenceInDays >= 0 && differenceInDays < weeklyMeals.length) {
      if (selectedDate != DateTime.now()) {
        _pageController.animateToPage(
          differenceInDays,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        moveToTodayMenu();
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(
                  "그 날짜에 맞는 식단 데이터가 아직 올라오지 않았어요",
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('확인'))
                ],
              ));
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    futureMealData = fetchMealDataDependingOnDorms(dormitoryType);
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final selectedDormitory = ref.watch(dormitoryProvider);
    final weeklyMealsAsyncValue = ref.watch(mealDataProvider);
    final DateTime currentDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF833D),
        title: Text(
            selectedDormitory == DormitoryType.sejong ? "세종기숙사" : "행복기숙사",
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
          return SizedBox(
            height: 700,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: weeklyMeals.length,
              itemBuilder: (context, index) {
                final meal = weeklyMeals[index];
                String date = meal.date;

                return buildMealPage(
                  meal,
                  index,
                  screenWidth,
                  screenHeight,
                  onDaySelected,
                  date,
                  moveToTodayMenu,
                  moveToPreviousPage,
                  moveToNextPage,
                  selectedDormitory,
                  currentDate,
                );
              },
            ),
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
          print('Error fetching meal data: $error');
          return Center(
            child: Text('Error: $error'),
          );
        },
      ),
    );
  }

  void moveToTodayMenu() {
    AsyncValue<List<MealData>> weeklyMeals = ref.watch(mealDataProvider);

    DateTime userAccessDate = DateTime.now();
    String formattedDate =
        DateFormat('MM-dd (E)', 'ko_KR').format(userAccessDate);

    int todayMenuIndex = -1;

    return weeklyMeals.when(
        data: (weeklyMeals) {
          // weeklyMeals 리스트를 순회하며 userAccessDate 와 일치하는 식단을 찾습니다.
          for (int i = 0; i < weeklyMeals.length; i++) {
            MealData meal = weeklyMeals[i];
            if (meal.date == formattedDate) {
              todayMenuIndex = i;
              print(todayMenuIndex);
              break;
            }
          }

          if (todayMenuIndex != -1) {
            // PageView를 해당 인덱스로 이동시킵니다.
            _pageController.animateToPage(
              todayMenuIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            // userAccessDate와 일치하는 식단이 없는 경우에 대한 처리
          }
        },
        error: (err, stack) => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('오늘 식단이 올라오지 않았어요.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('확인'),
                  ),
                ],
              ),
            ),
        loading: () => const CircularProgressIndicator());
  }

  void moveToNextPage() {
    final currentPage = _pageController.page ?? 0;
    final nextPage = currentPage + 1;
    if (nextPage < weeklyMeals.length) {
      _pageController.animateToPage(
        nextPage.toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void moveToPreviousPage() {
    final currentPage = _pageController.page ?? 0;
    final previousPage = currentPage - 1;
    if (previousPage >= 0) {
      _pageController.animateToPage(
        previousPage.toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }
}

Widget buildMealPage(
  MealData? meal,
  int index,
  double screenWidth,
  double screenHeight,
  void Function(DateTime selectedDay) onDaySelected,
  String date,
  VoidCallback onPressedToday,
  VoidCallback onPressedBack,
  VoidCallback onPressedForward,
  DormitoryType dormitoryType,
  DateTime currentDate,
) {
  if (meal != null) {
    return Column(
      children: [
        CalenderRow(
          width: screenWidth,
          height: screenHeight,
          onDateSelected: onDaySelected,
          date: date,
          onPressedBack: onPressedBack,
          onPressedForward: onPressedForward,
          onPressedToday: onPressedToday,
        ),
        SizedBox(
          height: screenHeight * 0.039,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: MealTimeTextRow(
              mealTime: getBreakfastTimeText(
                dormitoryType,
                currentDate,
              ),
              mealType: breakfast,
              width: screenWidth,
              height: screenHeight),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        BuildContainer(
          content: (dormitoryType == DormitoryType.happiness)
              ? '일반 : ${meal.breakfast}\n\nTAKE - OUT : ${meal.takeout}'
              : meal.breakfast,
          height: screenHeight,
          width: screenWidth,
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: MealTimeTextRow(
              mealTime: getLunchTimeText(dormitoryType, currentDate),
              mealType: lunch,
              width: screenWidth,
              height: screenHeight),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildContainer(
            content: meal.lunch,
            height: screenHeight,
            width: screenWidth,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: MealTimeTextRow(
              mealTime: getDinnerTimeText(dormitoryType, currentDate),
              mealType: dinner,
              width: screenWidth,
              height: screenHeight),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildContainer(
            content: meal.dinner,
            height: screenHeight,
            width: screenWidth,
          ),
        ),
      ],
    );
  } else {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Date: $currentDate\nNo meal data available.',
          style: GoogleFonts.notoSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

String getBreakfastTimeText(DormitoryType dormitoryType, DateTime currentDate) {
  if (dormitoryType == DormitoryType.sejong) {
    if (currentDate.isAfter(DateTime(2023, 6, 27)) &&
        currentDate.isBefore(DateTime(2023, 8, 31))) {
      return sejongVacationBreakfastTime;
    } else {
      return sejongBreakfastTime;
    }
  } else {
    if (isWeekday(currentDate)) {
      return happyBreakfastWeekTime;
    } else {
      return happyBreakfastTime;
    }
  }
}

String getLunchTimeText(DormitoryType dormitoryType, DateTime currentDate) {
  if (dormitoryType == DormitoryType.sejong) {
    if (currentDate.isAfter(DateTime(2023, 6, 27)) &&
        currentDate.isBefore(DateTime(2023, 8, 31))) {
      return sejongVacationLunchTime;
    } else {
      return sejongLunchTime;
    }
  } else {
    if (isWeekday(currentDate)) {
      return happyLunchWeekTime;
    } else {
      return happyLunchTime;
    }
  }
}

String getDinnerTimeText(DormitoryType dormitoryType, DateTime currentDate) {
  if (dormitoryType == DormitoryType.sejong) {
    if (currentDate.isAfter(DateTime(2023, 6, 27)) &&
        currentDate.isBefore(DateTime(2023, 8, 31))) {
      return sejongVacaitonDinnerTime;
    } else {
      return sejongDinnerTime;
    }
  } else {
    if (isWeekday(currentDate)) {
      return happyDinnerWeekTime;
    } else {
      return happyDinnerTime;
    }
  }
}

bool isWeekday(DateTime date) {
  return date.weekday >= DateTime.monday && date.weekday <= DateTime.friday;
}
