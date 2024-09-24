import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/dormitory/dormitory_bloc.dart';
import 'package:flutter_whattodayrice/common/utils/calendar_row_text.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';
import 'package:flutter_whattodayrice/presentation/view/components/button_template.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderRow extends ConsumerStatefulWidget {
  const CalenderRow({super.key, required this.mealDate});

  final String mealDate;

  @override
  ConsumerState<CalenderRow> createState() => _CalenderRowState();
}

class _CalenderRowState extends ConsumerState<CalenderRow> {
  DateTime? _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    _focusedDay = DateTime.parse(widget.mealDate);
    _selectedDay = DateTime.parse(widget.mealDate);

    return BlocBuilder<DormitoryBloc, DormitoryState>(
      builder: (context, state) {
        if (state is! DormitoryMealLoaded) {
          return const SizedBox.shrink();
        }

        final List<MealData> weeklyMealData = state.mealDataList;

        return Container(
          width: screenWidth,
          height: screenHeight * 0.06,
          decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(color: Colors.grey, width: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.13), // 그림자 색상
                spreadRadius: 1.0, // 그림자의 확장 반경
                blurRadius: 5.0, // 그림자의 흐림 정도
                offset: const Offset(0.0, 2.0), // 그림자의 위치
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    DateTime userAccessDate = DateTime.now();
                    String formattedDate = DateFormat('MM-dd (E)', 'ko_KR').format(userAccessDate);
                  },
                  child: Text(
                    '오늘',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold, color: ColorConstant.primary),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  const Spacer(),
                  CalendarRowIconButton(
                    iconShape: Icons.arrow_back_ios,
                    onPressed: () {},
                  ),
                  GestureDetector(
                    onTap: () => (BuildContext context) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width,
                            child: TableCalendar(
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: Theme.of(context).textTheme.bodySmall!,
                                weekendStyle: Theme.of(context).textTheme.bodySmall!,
                              ),
                              calendarStyle: CalendarStyle(
                                isTodayHighlighted: false,
                                selectedDecoration:
                                    const BoxDecoration(color: ColorConstant.primary, shape: BoxShape.circle),
                                outsideDaysVisible: true,
                                weekendTextStyle: Theme.of(context).textTheme.bodySmall!,
                                defaultTextStyle: Theme.of(context).textTheme.bodySmall!,
                                todayTextStyle: Theme.of(context).textTheme.bodySmall!,
                                selectedTextStyle: Theme.of(context).textTheme.bodySmall!,
                              ),
                              focusedDay: _focusedDay!,
                              firstDay: DateTime.parse(weeklyMealData.first.date),
                              lastDay: DateTime.parse(weeklyMealData.last.date),
                              headerVisible: false,
                              calendarFormat: CalendarFormat.week,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              locale: 'ko_KR',
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!isSameDay(_selectedDay, selectedDay)) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                }
                                String formattedDate = DateFormat('MM-dd (E)', 'ko_KR').format(selectedDay);

                                Navigator.pop(context);
                              },
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                              },
                            ),
                          ),
                        ),
                      );
                    }(context),
                    child: Text(
                      getCurrentDate(widget.mealDate),
                      style: Theme.of(context).textTheme.titleSmall!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CalendarRowIconButton(
                    iconShape: Icons.arrow_forward_ios,
                    onPressed: () {},
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
