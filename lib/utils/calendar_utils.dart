import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

Future<Object?> showCalendarDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    // barrierDismissible: true,
    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      return Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Dialog(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2023, 1, 1),
                  lastDay: DateTime(2023, 12, 31),
                  headerVisible: false,
                  calendarFormat: CalendarFormat.week,
                  locale: 'ko_KR',
                  onDaySelected: (selectedDay, focusedDay) {
                    DateTime date = selectedDay;
                    int weekdayIndex = date.weekday + 1;
                    Navigator.of(context).pop();
                    print('Selected date: $weekdayIndex');

                    // 해당 인덱스를 전달해줘야함
                  },
                ),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
