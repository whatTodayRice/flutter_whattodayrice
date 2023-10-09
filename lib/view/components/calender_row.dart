import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderRow extends StatefulWidget {
  const CalenderRow({
    super.key,
    required this.width,
    required this.height,
    required this.onDateSelected,
    required this.date,
    required this.onPressedBack,
    required this.onPressedForward,
    required this.onPressedToday,
    required this.dormitoryType,
  });

  final double width;
  final double height;
  final void Function(DateTime) onDateSelected;
  final DateTime date;

  final VoidCallback onPressedBack;
  final VoidCallback onPressedForward;
  final VoidCallback onPressedToday;
  final DormitoryType dormitoryType;

  @override
  State<CalenderRow> createState() => _CalenderRowState();
}

class _CalenderRowState extends State<CalenderRow> {
  DateTime currentDate = DateTime.now();

  DateTime monday = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday))
      .add(const Duration(days: 1));
  DateTime sunday = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday))
      .add(const Duration(days: 1))
      .subtract(const Duration(days: 1));

  String getCurrentDate() {
    final DateFormat dateFormat = DateFormat('(E)', 'ko_KR');
    String formattedDate =
        "${widget.date.month}월 ${widget.date.day}일 ${dateFormat.format(widget.date)}";
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final baseDate =
        widget.dormitoryType == DormitoryType.sejong1 ? sunday : monday;
    final startingDayOfWeek = widget.dormitoryType == DormitoryType.sejong1
        ? StartingDayOfWeek.sunday
        : StartingDayOfWeek.monday;
    return Container(
      width: widget.width,
      height: widget.height * 0.06,
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
              onPressed: widget.onPressedToday,
              child: Text(
                '오늘',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF833D)),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              MainScreenBackIconButton(
                iconShape: Icons.arrow_back_ios,
                onPressed: widget.onPressedBack,
              ),
              GestureDetector(
                onTap: () => (BuildContext context) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: TableCalendar(
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(fontSize: 12.0),
                            weekendStyle: TextStyle(fontSize: 12.0),
                          ),
                          calendarStyle: const CalendarStyle(
                            outsideDaysVisible: true,
                            weekendTextStyle: TextStyle(fontSize: 12.0),
                            defaultTextStyle: TextStyle(
                              fontSize: 10.0,
                            ),
                            todayTextStyle: TextStyle(
                              fontSize: 10.0,
                            ),
                            selectedTextStyle: TextStyle(
                              fontSize: 10.0,
                            ), // Adjust the font size for the selected date
                          ),
                          focusedDay: currentDate,
                          firstDay:
                              baseDate, //todo : 세종의 경우 sunday, 행복의 경우 monday
                          lastDay: baseDate.add(Duration(days: 6)),
                          //Date 값의 마지막 날짜만 넣어주기
                          headerVisible: false,
                          calendarFormat: CalendarFormat.week,
                          startingDayOfWeek:
                              startingDayOfWeek, //첫 시작을 월요일로 변경 가능하게함!
                          locale: 'ko_KR',
                          onDaySelected: (selectedDay, focusDay) {
                            widget.onDateSelected(selectedDay);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  );
                }(context),
                child: Text(
                  getCurrentDate(),
                  style: Theme.of(context).textTheme.titleSmall!,
                  textAlign: TextAlign.center,
                ),
              ),
              MainScreenForwardIconButton(
                iconShape: Icons.arrow_forward_ios,
                onPressed: widget.onPressedForward,
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
