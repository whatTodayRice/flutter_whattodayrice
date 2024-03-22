import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/common/utils/calendar_row_text.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/presentation/m_page_controller.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';
import 'package:flutter_whattodayrice/presentation/providers/meal/meal_data_provider.dart';
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
    final userDormitoryType = ref.watch(dormitoryProvider);
    final List<MealData> weeklyMeals = ref.watch(mealDataProvider).value!;

    _focusedDay = DateTime.parse(widget.mealDate);
    _selectedDay = DateTime.parse(widget.mealDate);

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
                String formattedDate =
                    DateFormat('MM-dd (E)', 'ko_KR').format(userAccessDate);

                int pageIndex = weeklyMeals.indexWhere((meal) {
                  DateTime mealDate = DateTime.parse(meal.date);
                  String formattedMealDate =
                      DateFormat('MM-dd (E)', 'ko_KR').format(mealDate);
                  return formattedMealDate == formattedDate;
                });
                ref
                    .read(pageNavigationStateProvider.notifier)
                    .moveToTodayMenu(pageIndex);
              },
              child: Text(
                '오늘',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: ColorConstants.primary),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              CalendarRowIconButton(
                iconShape: Icons.arrow_back_ios,
                onPressed: () {
                  ref
                      .read(pageNavigationStateProvider.notifier)
                      .moveToYesterdayMenu();
                },
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
                            weekdayStyle:
                                Theme.of(context).textTheme.bodySmall!,
                            weekendStyle:
                                Theme.of(context).textTheme.bodySmall!,
                          ),
                          calendarStyle: CalendarStyle(
                            isTodayHighlighted: false,
                            selectedDecoration: const BoxDecoration(
                                color: ColorConstants.primary,
                                shape: BoxShape.circle),
                            outsideDaysVisible: true,
                            weekendTextStyle:
                                Theme.of(context).textTheme.bodySmall!,
                            defaultTextStyle:
                                Theme.of(context).textTheme.bodySmall!,
                            todayTextStyle:
                                Theme.of(context).textTheme.bodySmall!,
                            selectedTextStyle:
                                Theme.of(context).textTheme.bodySmall!,
                          ),
                          focusedDay: _focusedDay!,
                          firstDay: DateTime.parse(weeklyMeals.first.date),
                          lastDay: DateTime.parse(weeklyMeals.last.date),
                          headerVisible: false,
                          calendarFormat: CalendarFormat.week,
                          startingDayOfWeek:
                              userDormitoryType == DormitoryType.happiness
                                  ? StartingDayOfWeek.monday
                                  : StartingDayOfWeek.sunday,
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
                            String formattedDate =
                                DateFormat('MM-dd (E)', 'ko_KR')
                                    .format(selectedDay);

                            int pageIndex = weeklyMeals.indexWhere((meal) {
                              DateTime mealDate = DateTime.parse(meal.date);
                              String formattedMealDate =
                                  DateFormat('MM-dd (E)', 'ko_KR')
                                      .format(mealDate);
                              return formattedMealDate == formattedDate;
                            });
                            ref
                                .read(pageNavigationStateProvider.notifier)
                                .moveToSelectedMenu(pageIndex);
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
                onPressed: () {
                  ref
                      .read(pageNavigationStateProvider.notifier)
                      .moveToTommorrowMenu();
                },
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
