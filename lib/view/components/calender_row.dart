import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
import 'package:flutter_whattodayrice/utils/calendar_utils.dart';

class CalenderRow extends StatefulWidget {
  const CalenderRow({
    super.key,
    required this.width,
    required this.height,
    required this.onPressedBack,
    required this.onPressedForward,
    required this.onPressedToday,
  });

  final double width;
  final double height;
  final VoidCallback onPressedBack;
  final VoidCallback onPressedForward;
  final VoidCallback onPressedToday;

  @override
  State<CalenderRow> createState() => _CalenderRowState();
}

class _CalenderRowState extends State<CalenderRow> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Spacer(),
          MainScreenBackIconButton(
            iconShape: Icons.arrow_back_ios,
            onPressed: widget.onPressedBack,
          ),
          GestureDetector(
            onTap: () {
              showCalendarDialog(context); // 캘린더 다이얼로그가 뜨도록 하는 함수
            },
            child: const Text(
              '4월 29일',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          MainScreenForwardIconButton(
            iconShape: Icons.arrow_forward_ios,
            onPressed: widget.onPressedForward,
          ),
          const Spacer(),
          TextButton(onPressed: widget.onPressedToday, child: const Text('오늘')),
        ],
      ),
    );
  }
}
