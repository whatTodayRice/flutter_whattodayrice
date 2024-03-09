import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
import 'package:flutter_whattodayrice/view/components/text_template.dart';
import 'package:flutter_whattodayrice/view/components/bottom_sheet_utils.dart';
import 'package:flutter_whattodayrice/view/components/notification_switch.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_widget/home_widget.dart';

const String androidWidgetName = 'FullMealsWidget';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings_screen';

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool isDarkMood = false;
  bool isSwitched = false;
  static const IconData arrowDropDown =
      IconData(0xe098, fontFamily: 'MaterialIcons');

  Widget buildNotificationSwitch(BuildContext context) {
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
    const String androidWidgetName = 'MealWidget';

    final selectedDormitory = ref.watch(dormitoryProvider);

    if (selectedDormitory == DormitoryType.sejong1 ||
        selectedDormitory == DormitoryType.sejong2) {
      HomeWidget.saveWidgetData<bool>('is_sejong', true);
    } else {
      HomeWidget.saveWidgetData<bool>('is_sejong', false);
    }

    HomeWidget.updateWidget(androidName: androidWidgetName);

    return SafeArea(
      child: Scaffold(
        body: Column(
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  buildBoldText('기숙사 변경'),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        buildDormitoryBottomSheet(context, ref);
                      },
                      child: Text(
                        (selectedDormitory == DormitoryType.sejong1 ||
                                selectedDormitory == DormitoryType.sejong2)
                            ? "세종기숙사"
                            : "행복기숙사",
                        style: GoogleFonts.notoSans(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                  const Icon(arrowDropDown)
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  buildBoldText('테마 변경'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      buildThemeBottomSheet(
                        context,
                      );
                    },
                    child: Text(
                      buildThemeText(
                          convertToThemeMode(AdaptiveTheme.of(context).mode)),
                      style: GoogleFonts.notoSans(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Icon(arrowDropDown)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String buildThemeText(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      return '라이트 모드';
    case ThemeMode.dark:
      return '다크 모드';
    case ThemeMode.system:
    default:
      return '시스템 설정';
  }
}

ThemeMode convertToThemeMode(AdaptiveThemeMode adaptiveThemeMode) {
  switch (adaptiveThemeMode) {
    case AdaptiveThemeMode.light:
      return ThemeMode.light;

    case AdaptiveThemeMode.dark:
      return ThemeMode.dark;

    case AdaptiveThemeMode.system:
    default:
      return ThemeMode.system;
  }
}
