import 'package:flutter/material.dart';

import '../../../common/theme/constants.dart';

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({super.key});

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return Text(daysOfWeek[index]);
        });
  }
}
