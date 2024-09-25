import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/dormitory/dormitory_bloc.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_menu_fragment.dart';

class HomeOption extends StatefulWidget {
  const HomeOption({
    super.key,
    required this.dormitoryBloc,
  });

  final DormitoryBloc dormitoryBloc;

  @override
  State<HomeOption> createState() => _HomeOptionState();
}

class _HomeOptionState extends State<HomeOption> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    final loggedInDayIndex = DateTime.now().toUtc().add(const Duration(hours: 9)).weekday;
    pageController = PageController(initialPage: loggedInDayIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.dormitoryBloc,
      builder: (context, state) {
        if (state is! DormitoryMealLoaded) {
          return const SizedBox();
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
    );
  }
}
