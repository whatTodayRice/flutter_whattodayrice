import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/modules/home/bloc/dormitory_meal_bloc.dart';
import 'package:flutter_whattodayrice/modules/home/helper/dorm_meal_helper.dart';
import 'package:flutter_whattodayrice/modules/home/widget/menu_card/date_cell.dart';

class DateSelector extends StatelessWidget {
  final List<String> dateList;

  const DateSelector({super.key, required this.dateList});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DormitoryMealBloc, DormitoryMealState>(
      builder: (context, state) {
        if (state is! DormitoryMealLoaded) {
          return const SizedBox();
        }

        int selectedDayIndex = state.selectedDayIndex;

        return SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dateList.length,
            itemBuilder: (context, index) {
              // 문자열을 DateTime(한국 시간(KST))으로 변환
              final date = getKoreaDateTime(DateTime.parse(dateList[index]));

              final isSelected = index == selectedDayIndex;

              return DateCell(
                date: date,
                isSelected: isSelected,
                onTap: () => context.read<DormitoryMealBloc>().add(DormitoryMealDateSelected(selectedDayIndex: index)),
              );
            },
          ),
        );
      },
    );
  }
}
