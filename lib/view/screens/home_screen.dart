import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/services/fetch_meals_from_db.dart';
import 'package:flutter_whattodayrice/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/view/screens/settings_screen.dart';
import 'package:intl/intl.dart';
import '../../models/dormitory.dart';
import '../../models/meal.dart';
import '../components/meal_container.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/providers/meal_data_provider.dart';
import 'package:flutter_whattodayrice/services/fetch_happy_meals.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);


  List<MealData?> weeklyMeals = [];
  DormitoryType dormitoryType = DormitoryType.happiness;

  void updateDormitoryMeal(DormitoryType dormitoryType) {
    fetchMealDataFromDB(dormitoryType).then((newData) {
      if (mounted) {
        setState(() {
          weeklyMeals = newData;
        });
      }
    }).catchError((error) {
      // 에러 처리
      print('Error fetching meal data: $error');
      if (mounted) {
        setState(() {
          weeklyMeals = [];
        });
      }
    });
  }

  DateTime sunday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - (DateTime.now().weekday - 1)).subtract(Duration(days: 1));

  DateTime monday =DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - (DateTime.now().weekday - 1));

  DateTime selectedDate = DateTime.now();

  void onDaySelected(DateTime selectedDay) {
    setState(() {
      selectedDate = selectedDay;
    });

    //세종의 경우 sunday와의 차이를 구해야하고 , 행복의 경우 monday와의 차이를 구해야함.
    int differenceInDays = selectedDay.difference(sunday).inDays;
    print('차이:$differenceInDays');


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
    updateDormitoryMeal(dormitoryType);

  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final selectedDormitory = ref.watch(dormitoryProvider);
    final weeklyMealsAsynsValue = ref.watch(mealDataProvider);

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
      body: weeklyMealsAsynsValue.when(
        data: (weeklyMeals) {
          return weeklyMeals.isNotEmpty
              ? SizedBox(
                  height: 700,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: weeklyMeals.length,
                    itemBuilder: (context, index) {
                      var meal = weeklyMeals[index];

                      DateTime date = selectedDormitory == DormitoryType.happiness
                          ? monday
                          : sunday;
                      print('넘겨주는 date: $date');
                      print('넘겨주는 index : $index');
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
                      );
                    },
                  ),
                )
              : const Center(
                  child:
                      CircularProgressIndicator(), // 데이터를 가져오는 동안 로딩 표시  //추후 삭제 할 것
                );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
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
    DateTime userAccessDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(userAccessDate);

    // weeklyMeals 리스트를 순회하며 userAccessDate와 일치하는 식단을 찾습니다.
    int todayMenuIndex = -1;

    for (int i = 0; i < weeklyMeals.length; i++) {
      MealData? meal = weeklyMeals[i];
      print(weeklyMeals[i]?.date.toString());
      print('0번째날짜 :${weeklyMeals[0]?.date.toString()}' );

      if (meal?.date == formattedDate) {
          print('date가 같아요');
          todayMenuIndex = i;
          break;
        }
    }

    if (todayMenuIndex != -1) {
      // PageView를 해당 인덱스로 이동시킵니다.
      print('여기로 이동해요 : $todayMenuIndex' );
      _pageController.animateToPage(
      todayMenuIndex,
    duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // userAccessDate와 일치하는 식단이 없는 경우에 대한 처리
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('오늘의 식단이 없습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  void moveToNextPage() {
    var currentPage = _pageController.page ?? 0;
    final nextPage = currentPage + 1;
    if (nextPage < weeklyMeals.length) {
      _pageController.animateToPage(
        nextPage.toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      print('nextPage: $nextPage');
    }
  }

  void moveToPreviousPage() {
    var currentPage = _pageController.page ?? 0;
    final previousPage = currentPage - 1;
    print('previousPage: $previousPage');
    if (previousPage >= -1) {
      _pageController.animateToPage(
        previousPage.toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,

      );
print('previousPage : $previousPage');
    }
    }
  }


Widget buildMealPage(
  MealData? meal,
  int index,
  double screenWidth,
  double screenHeight,
  void Function(DateTime selectedDay) onDaySelected,
  DateTime date,
  VoidCallback onPressedToday,
  VoidCallback onPressedBack,
  VoidCallback onPressedForward,
  DormitoryType dormitoryType,
) {
  DateTime currentDate = DateTime.now();
  DateTime modifiedDate = date.add(Duration(days: index));

  String formattedDate = DateFormat('yyyy-MM-dd').format(modifiedDate);

  if (meal != null) {
    return Column(
      children: [
        CalenderRow(
          width: screenWidth,
          height: screenHeight,
          onDateSelected: onDaySelected,
          date: modifiedDate,
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
              : '${meal.breakfast}',
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
            content: '${meal.lunch}',
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
            content: '${meal.dinner}',
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
          'Date: $formattedDate\nNo meal data available.',
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
