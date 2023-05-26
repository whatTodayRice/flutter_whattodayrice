import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

Future<Object?> showCalendarDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      return Positioned(
        top: 20,
        left: 0,
        right: 0,
        child: Dialog(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime(2023, 1, 1),
              lastDay: DateTime(2023, 12, 31),
              headerVisible: false,
              calendarFormat: CalendarFormat.week,
              locale: 'ko_KR',
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
