import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
import 'package:flutter_whattodayrice/theme/constants.dart';
import '../components/notification_container.dart';
import 'package:flutter_whattodayrice/theme/text_template.dart';
import '../components/asset_path.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final imgAlarmWidth = screenWidth * 0.0694;
    final imgAlarmHeight = screenHeight * 0.0351;

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.0174),
          const Row(
            children: [
              BackIconButton(),
            ],
          ),
          SizedBox(width: screenWidth, height: screenHeight * 0.1362),
          Image.asset(
            AssetPaths.alarm,
            width: imgAlarmWidth,
            height: imgAlarmHeight,
          ),
          SizedBox(height: screenHeight * 0.0365),
          notiTitleText,
          SizedBox(height: screenHeight * 0.0154),
          notiSubTitleText,
          SizedBox(height: screenHeight * 0.0912),
          NotiContainer(
              width: screenWidth,
              height: screenHeight,
              notiTitle: notificationTomorrowTxtSpan),
          SizedBox(height: screenHeight * 0.0280),
          NotiContainer(
              width: screenWidth,
              height: screenHeight,
              notiTitle: notificationNextWeekTextSpan),
          SizedBox(height: screenHeight * 0.2022),
          ReusableButton(
            buttonText: notiSettingText,
            width: screenWidth * 0.9444,
            height: screenHeight * 0.0702,
          ),
          TextButton(
            // 텍스트 버튼  클릭 시 메인 화면으로 이동하도록 하기
            onPressed: () {},
            child: jumpToMainText,
          ),
        ],
      ),
    );
  }
}
