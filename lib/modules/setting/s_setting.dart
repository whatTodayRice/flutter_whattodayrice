import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/common/widget/app_elevated_button.dart';
import 'package:flutter_whattodayrice/modules/setting/bloc/setting_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/common/theme/text_template.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_whattodayrice/modules/setting/widget/notification_switch.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

const String androidWidgetName = 'FullMealsWidget';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMood = false;
  bool isSwitched = false;
  static const IconData arrowDropDown = IconData(0xe098, fontFamily: 'MaterialIcons');

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
    // const String androidWidgetName = 'MealWidget';
    //
    // HomeWidget.saveWidgetData<bool>('is_sejong', false);
    //
    // HomeWidget.updateWidget(androidName: androidWidgetName);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: buildSectionTitle('설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocListener<SettingBloc, SettingState>(
          listener: (context, state) {
            if (state is SettingLoaded && state.isLogOut == true) {
              context.goNamed(AppRouteState.signIn.name);

              return;
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppElevatedButton(
                title: '로그아웃',
                onPressed: () => context.read<SettingBloc>().add(const SettingLogOutRequested()),
                textStyle: Theme.of(context).textTheme.bodyMedium!,
                buttonBorderColor: AppColor.primary,
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.black,
                borderRadiusValue: 12,
                elevation: 0,
                disabledForegroundColor: AppColor.primary,
                disabledBackgroundColor: Colors.black,
              ),
              Row(
                children: [
                  buildBoldText('기숙사 변경'),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "행복기숙사",
                        style: GoogleFonts.notoSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.primary),
                      )),
                  const Icon(arrowDropDown)
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  buildBoldText('테마 변경'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      buildThemeText(convertToThemeMode(AdaptiveTheme.of(context).mode)),
                      style: GoogleFonts.notoSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.primary),
                    ),
                  ),
                  const Icon(arrowDropDown)
                ],
              ),
              SizedBox(height: 15.h),
              Text('🍚 이런 기능이 추가될거예요.', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 15.h),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      // TODO: 나중에 구현
                      ),
                ),
              ),
            ],
          ),
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
      return ThemeMode.system;
  }
}
