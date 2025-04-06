import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/utils/login_validator.dart';
import 'package:flutter_whattodayrice/common/widget/app_bar_normal.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:flutter_whattodayrice/modules/setting/bloc/setting_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

const String androidWidgetName = 'FullMealsWidget';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final pagingController = PagingController<String, Post>(firstPageKey: '');

  @override
  void initState() {
    context.read<SettingBloc>().add(const SettingLoadRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // const String androidWidgetName = 'MealWidget';
    //
    // HomeWidget.saveWidgetData<bool>('is_sejong', false);
    //
    // HomeWidget.updateWidget(androidName: androidWidgetName);

    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is SettingLogoutSucceed) {
          context.goNamed(AppRouteState.secondHand.name);
        }
      },
      child: Scaffold(
        appBar: const AppBarNormal(title: '설정', centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<SettingBloc, SettingState>(
            buildWhen: (previous, current) => current is SettingLoaded,
            builder: (context, state) {
              if (state is! SettingLoaded) {
                return const Center(child: AppLoadingIndicator());
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      state.items.length,
                      (index) => SettingItem(item: state.items[index]),
                    ),
                    if (getIt<UserRepository>().getUserProfileFromCache() != null) ...[
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => context.read<SettingBloc>().add(const SettingLogOutRequested()),
                            child: Text(
                              '로그아웃',
                              style: AppTextStyle.regular14
                                  .copyWith(color: AppColor.gray8C8C8C, decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
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

class SettingItem extends StatelessWidget {
  const SettingItem({super.key, required this.item});

  final SettingItemEnum item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        switch (item) {
          case SettingItemEnum.siteTerms:
            AppDefaultDialog.show(
              context,
              title: '안내',
              content: '추후 안내될 예정이예요.',
              confirmButtonText: '확인',
            );

            return;

          default:
            if (LoginValidator.isUserLoggedIn() != true) {
              final result = await AppDefaultDialog.show(
                context,
                title: '안내',
                content: '로그인 이후 확인할 수 있어요.',
                confirmButtonText: '로그인 하기',
                onConfirm: () => Navigator.of(context).pop(true),
                cancelButtonText: '취소',
              );

              if (result != true) {
                return;
              }

              final loginResult = await context.pushNamed(AppRouteState.signIn.name);

              if (loginResult != true) {
                return;
              }

              context.read<SettingBloc>().add(const SettingLoadRequested());

              return;
            }

            context.pushNamed(item.routeName);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Text(
              item.displayValue,
              style: AppTextStyle.regular16.copyWith(color: AppColor.black121212),
            ),
            const Spacer(),
            Assets.images.svg.iconRightArrowGray.svg(fit: BoxFit.scaleDown),
          ],
        ),
      ),
    );
  }
}
