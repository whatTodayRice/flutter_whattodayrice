import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_meal_type.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/modules/meal/bloc/dormitory_meal_bloc.dart';
import 'package:flutter_whattodayrice/modules/meal/widget/date/date_selector.dart';
import 'package:flutter_whattodayrice/modules/meal/widget/menu_card/menu_card.dart';
import 'package:go_router/go_router.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  void initState() {
    super.initState();

    final bloc = context.read<DormitoryMealBloc>();

    bloc.add(const DormitoryMealLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("오늘의 메뉴", style: Theme.of(context).textTheme.titleMedium!),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColor.grayD9D9D9),
            onPressed: () => context.pushNamed(AppRouteState.setting.name),
          ),
        ],
        backgroundColor: AppColor.homeOptionBackgroundColor,
      ),
      backgroundColor: AppColor.homeOptionBackgroundColor,
      body: BlocBuilder<DormitoryMealBloc, DormitoryMealState>(
        builder: (context, state) {
          if (state is! DormitoryMealLoaded) {
            return const Center(child: AppLoadingIndicator());
          }

          final List<MealData> mealDataList = state.mealDataList;
          final int selectedDayIndex = state.selectedDayIndex;
          final MealType availableMealType = state.availableMealType;
          final List<String> dateList = mealDataList.map((mealData) => mealData.date).toList();

          final bool isWeekend = selectedDayIndex == 5 || selectedDayIndex == 6;

          return RefreshIndicator(
            onRefresh: () async => context.read<DormitoryMealBloc>().add(const DormitoryMealLoadRequested()),
            child: Column(
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
            ),
          );
        },
      ),
    );
  }
}
