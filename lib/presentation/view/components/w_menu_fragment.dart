import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/common/utils/restaurant_time.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/presentation/providers/meal/meal_data_provider.dart';
import 'package:flutter_whattodayrice/presentation/view/components/calender_row.dart';
import 'package:flutter_whattodayrice/presentation/view/components/meal_time_row.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_meal_container.dart';

class MenuFragment extends ConsumerWidget {
  const MenuFragment({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final dormitoryType = ref.watch(dormitoryProvider);
    final List<MealData> weeklyMeals = ref.watch(mealDataProvider).value!;
    final DateTime weeklyFirstDate = DateTime.parse(weeklyMeals.first.date);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          CalenderRow(
            mealDate: weeklyMeals[index].date,
          ),
          SizedBox(
            height: screenHeight * 0.039,
          ),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: getAvailableTimeText(
                  dormitoryType: dormitoryType,
                  mealType: MealType.breakfast,
                  date: weeklyFirstDate,
                  index: index),
              mealType: MealType.breakfast,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(
              content: (dormitoryType == DormitoryType.happiness)
                  ? '일반 : ${weeklyMeals[index].breakfast}\n\nTAKE - OUT : ${weeklyMeals[index].takeout}'
                  : weeklyMeals[index].breakfast,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: getAvailableTimeText(
                  dormitoryType: dormitoryType,
                  mealType: MealType.lunch,
                  date: weeklyFirstDate,
                  index: index),
              mealType: MealType.lunch,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(
              content: weeklyMeals[index].lunch,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Flexible(
            flex: 1,
            child: MealTimeTextRow(
              mealTime: getAvailableTimeText(
                  dormitoryType: dormitoryType,
                  mealType: MealType.dinner,
                  date: weeklyFirstDate,
                  index: index),
              mealType: MealType.dinner,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: MealContainer(
              content: weeklyMeals[index].dinner,
            ),
          ),
        ],
      ),
    );
  }
}
