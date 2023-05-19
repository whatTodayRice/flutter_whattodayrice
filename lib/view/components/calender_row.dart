import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
import 'package:flutter_whattodayrice/utils/calendar_utils.dart';

class CalenderRow extends StatelessWidget {
  const CalenderRow({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.06,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const MainScreenIconButton(
            iconShape: Icons.arrow_back_ios,
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
          const MainScreenIconButton(
            iconShape: Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
