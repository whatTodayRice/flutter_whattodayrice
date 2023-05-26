import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
import 'package:flutter_whattodayrice/view/components/text_template.dart';
import 'package:flutter_whattodayrice/view/components/bottom_sheet_utils.dart';
import 'package:flutter_whattodayrice/view/components/notification_switch.dart';

import '../components/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const IconData arrowDropDown =
      IconData(0xe098, fontFamily: 'MaterialIcons');
  bool isSwitched = false;

  Widget buildNotificationSwitch() {
    return NotificationSwitch(
        isSwitched: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 30.0, 15.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.topLeft, children: [
              const BackIconButton(),
              Align(
                alignment: Alignment.center,
                child: buildSectionTitle('설정'),
              )
            ]),

            const SizedBox(
              height: 10,
            ),
            buildSectionTitle('알림'),
            const SizedBox(
              height: 20,
            ),
            buildSectionSubtitle('식단 알림 수신'),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                notyExplainText,
                style: TextStyle(color: Colors.grey[500], fontSize: 8),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            buildNotificationSwitch(),

            //구분선 삽입
            const SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[300],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                buildBoldText('기숙사 변경'),
                const Spacer(),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          buildDormitoryBottomSheet(context);
                        },
                        child: const Text(
                          '세종기숙사',
                          style: TextStyle(fontSize: 12),
                        )),
                    const Icon(arrowDropDown)
                  ],
                )
              ],
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                buildBoldText('테마 변경'),
                const Spacer(),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          buildThemeBottomSheet(context);
                        },
                        child: const Text(
                          '시스템 설정',
                          style: TextStyle(fontSize: 12),
                        )),
                    const Icon(arrowDropDown)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
