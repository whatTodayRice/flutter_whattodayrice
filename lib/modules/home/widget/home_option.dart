import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_meal_type.dart';
import 'package:flutter_whattodayrice/modules/home/bloc/dormitory_bloc.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/modules/home/widget/date/date_selector.dart';
import 'package:flutter_whattodayrice/modules/home/widget/menu_card/menu_card.dart';

class HomeOption extends StatefulWidget {
  const HomeOption({
    super.key,
    required this.dormitoryBloc,
  });

  final DormitoryMealBloc dormitoryBloc;

  @override
  State<HomeOption> createState() => _HomeOptionState();
}

class _HomeOptionState extends State<HomeOption> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.dormitoryBloc,
      builder: (context, state) {
        if (state is! DormitoryMealLoaded) {
          return const SizedBox();
        }

        final List<MealData> mealDataList = state.mealDataList;
        final int selectedDayIndex = state.selectedDayIndex;
        final MealType availableMealType = state.availableMealType;
        final List<String> dateList = mealDataList.map((mealData) => mealData.date).toList();

        final bool isWeekend = selectedDayIndex == 5 || selectedDayIndex == 6;

        return Column(
          children: [
            DateSelector(dateList: dateList),
            SizedBox(height: 12.h),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  MenuCard(
                    mealType: MealType.breakfast,
                    normalMenu: mealDataList[selectedDayIndex].breakfast,
                    takeOut: mealDataList[selectedDayIndex].takeout,
                    isActive: availableMealType == MealType.breakfast,
                    isWeekend: isWeekend,
                    availableMealTime: "7:30 ~ 9:30",
                  ),
                  SizedBox(height: 20.h),
                  MenuCard(
                    mealType: MealType.lunch,
                    normalMenu: mealDataList[selectedDayIndex].lunchNormal,
                    premiumMenu: mealDataList[selectedDayIndex].lunchPremium,
                    isActive: availableMealType == MealType.lunch,
                    isWeekend: isWeekend,
                    availableMealTime: "11:30 ~ 14:00",
                  ),
                  SizedBox(height: 20.h),
                  MenuCard(
                    mealType: MealType.dinner,
                    normalMenu: mealDataList[selectedDayIndex].dinnerNormal,
                    premiumMenu: mealDataList[selectedDayIndex].dinnerPremium,
                    isWeekend: isWeekend,
                    isActive: availableMealType == MealType.dinner,
                    availableMealTime: "16:50 ~ 19:00",
                  ),
                ],
              ),
            )),
          ],
        );
      },
    );
  }
}
