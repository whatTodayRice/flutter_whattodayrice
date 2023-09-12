import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';

// bottom sheet를 보여주는 함수
void showBottomSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
      return SizedBox(
        height: screenHeight * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: content,
        ),
      );
    },
  );
}

//theme 에 대한 bottom sheet 구성 내용
void buildThemeBottomSheet(BuildContext context) {
  const content = Column(
    children: [
      SelectButton(buttonText: '시스템 설정'),
      SizedBox(height: 10),
      SelectButton(buttonText: '다크 모드'),
      SizedBox(height: 10),
      SelectButton(buttonText: '라이트 모드'),
    ],
  );
  showBottomSheet(context, content);
}

//dormitory에 대한 bottom sheet 내용 구성
void buildDormitoryBottomSheet(BuildContext context) {
  final content = const Column(
    children: [
      SelectButton(buttonText: '행복기숙사'),
      SizedBox(height: 10),
      SelectButton(buttonText: '세종기숙사'),
    ],
  );
  showBottomSheet(context, content);
}
