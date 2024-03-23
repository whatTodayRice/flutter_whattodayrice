import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/presentation/providers/user_provider.dart';
import 'package:flutter_whattodayrice/presentation/view/components/button_template.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';

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
      final screenWidth = MediaQuery.of(context).size.width;
      return SizedBox(
        height: screenHeight * 0.3,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: content,
        ),
      );
    },
  );
}

//theme 에 대한 bottom sheet 구성 내용
void buildThemeBottomSheet(
  BuildContext context,
) {
  final currentMode = AdaptiveTheme.of(context).mode;
  final content = Column(
    children: [
      SelectThemeButton(
        adaptiveThemeMode: currentMode,
        buttonText: '시스템 설정',
        onPressed: () {
          AdaptiveTheme.of(context).setSystem();
          Navigator.pop(context);
        },
      ),
      const SizedBox(height: 10),
      SelectThemeButton(
        adaptiveThemeMode: currentMode,
        buttonText: '다크 모드',
        onPressed: () {
          AdaptiveTheme.of(context).setDark();
          Navigator.pop(context);
        },
      ),
      const SizedBox(height: 10),
      SelectThemeButton(
        adaptiveThemeMode: currentMode,
        buttonText: '라이트 모드',
        onPressed: () {
          AdaptiveTheme.of(context).setLight();
          Navigator.pop(context);
        },
      ),
    ],
  );
  showBottomSheet(context, content);
}

//dormitory에 대한 bottom sheet 내용 구성
void buildDormitoryBottomSheet(
  BuildContext context,
  WidgetRef ref,
) {
  final content = Column(
    children: [
      SelectButton(
        buttonText: '행복기숙사',
        onPressed: () {
          ref.read(userProivder).changeUserDormitory(DormitoryType.happiness);
          saveDormitory(DormitoryType.happiness);
          Navigator.pop(context);
        },
      ),
      SizedBox(height: 10.h),
      SelectButton(
        buttonText: '세종 1관',
        onPressed: () {
          //todo : 기숙사 세종 1과 세종2로 나눠야함.
          ref.read(userProivder).changeUserDormitory(DormitoryType.sejong1);
          saveDormitory(DormitoryType.sejong1);
          Navigator.pop(context);
        },
      ),
      SizedBox(height: 10.h),
      SelectButton(
        buttonText: '세종 2관',
        onPressed: () {
          //todo : 기숙사 세종 1과 세종2로 나눠야함.
          ref.read(userProivder).changeUserDormitory(DormitoryType.sejong2);
          saveDormitory(DormitoryType.sejong2);
          Navigator.pop(context);
        },
      ),
    ],
  );
  showBottomSheet(context, content);
}
