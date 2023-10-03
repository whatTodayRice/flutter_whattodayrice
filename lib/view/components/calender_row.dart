import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
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
  });

  final double width;
  final double height;
  final void Function(DateTime) onDateSelected;
  final String date;
  final VoidCallback onPressedBack;
  final VoidCallback onPressedForward;
  final VoidCallback onPressedToday;

  @override
  State<CalenderRow> createState() => _CalenderRowState();
}

class _CalenderRowState extends State<CalenderRow> {
  DateTime currentDate = DateTime.now();

  DateTime monday =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  DateTime sunday = DateTime.now()
      .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday + 6));

  // String getCurrentDate() {
  //   DateFormat dateFormat = DateFormat('(E)', 'ko_KR');
  //   String formattedDate =
  //       "${widget.date.month}월 ${widget.date.day}일 ${dateFormat.format(widget.date)}";
  //   return formattedDate;
  // }

  @override
  Widget build(BuildContext context) {
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
                            weekdayStyle: TextStyle(fontSize: 10.0),
                            weekendStyle: TextStyle(fontSize: 10.0),
                          ),
                          calendarStyle: const CalendarStyle(
                            outsideDaysVisible: true,
                            weekendTextStyle: TextStyle(fontSize: 10.0),
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
                          firstDay: monday,
                          lastDay: sunday,
                          headerVisible: false,
                          calendarFormat: CalendarFormat.week,
                          locale: 'ko_KR',
                          onDaySelected: (selectedDate, focusDay) {
                            Navigator.pop(context);
                            widget.onDateSelected(selectedDate);
                          },
                        ),
                      ),
                    ),
                  );
                }(context),
                child: Text(
                  widget.date,
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
