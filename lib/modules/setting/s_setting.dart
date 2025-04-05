import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/common/widget/post_list_item.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/modules/setting/bloc/setting_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_whattodayrice/modules/sign_in/widget/kakao_button.dart';
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

    pagingController.addPageRequestListener((_) => context.read<SettingBloc>().add(const SettingMyPostLoadRequested()));

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
        final bloc = context.read<SettingBloc>();

        if (state is SettingMyPostLoaded) {
          pagingController.value = PagingState(itemList: state.myPostList, nextPageKey: state.lastDocId);
        } else if (state is SettingLogoutSucceed) {
          context.goNamed(AppRouteState.secondHand.name);
        } else if (state is SettingLoginSucceed) {
          bloc.add(const SettingLoadRequested());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Assets.images.svg.iconRightArrowGray.svg(fit: BoxFit.scaleDown),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<SettingBloc, SettingState>(
            buildWhen: (previous, current) => current is SettingLoaded,
            builder: (context, state) {
              if (state is! SettingLoaded) {
                return const Center(child: AppLoadingIndicator());
              }

              final profile = state.profile;

              if (profile == null) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          '로그인 후 나눔 거래를 시작해보세요.',
                          style: AppTextStyle.bold20.copyWith(color: AppColor.black121212),
                        ),
                        const SizedBox(height: 24),
                        KakaoButton(
                          onTap: () => context.read<SettingBloc>().add(const SettingLoginRequested()),
                        ),
                        const SizedBox(height: 24),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Assets.images.png.imageSecondHandExample.image()),
                      ],
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '안녕하세요 ${profile.nickname}님!',
                        style: AppTextStyle.bold20.copyWith(color: AppColor.orangeFF823B),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '${profile.nickname}님이 작성한 글을 모아봤어요.',
                        style: AppTextStyle.bold16.copyWith(color: AppColor.black121212),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.black121212.withValues(alpha: 0.5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: MediaQueryData.fromView(View.of(context)).size.height * 0.5,
                      child: PagedListView<String, Post>.separated(
                        pagingController: pagingController,
                        builderDelegate: PagedChildBuilderDelegate(
                          itemBuilder: (context, item, index) => PostListItem(
                            onTap: () {
                              if (item.id == null) {
                                return;
                              }

                              context.goNamed(AppRouteState.postDetail.name, pathParameters: {'id': item.id!});
                            },
                            imageUrl: item.imageUrl,
                            title: item.title,
                            price: item.price,
                            location: item.location,
                            createdAt: item.createdAt,
                            sellStatus: item.sellStatus,
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                      ),
                    ),
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
