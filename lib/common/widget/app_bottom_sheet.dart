import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, this.asset, required this.content, required this.onTap});

  final Widget? asset;
  final String content;
  final void Function()? onTap;

  static Future<bool?> show(
    BuildContext context, {
    required String content,
    Widget? asset,
    void Function()? onTap,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => AppBottomSheet(asset: asset, content: content, onTap: onTap),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 130,
        child: Center(
          child: GestureDetector(
            onTap: onTap ?? () => Navigator.of(context).pop(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (asset != null) asset!,
                SizedBox(width: 8.h),
                Text(content, style: AppTextStyle.bold20.copyWith(color: AppColor.orangeFF6060)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ModerationBottomSheet extends StatelessWidget {
  const ModerationBottomSheet({super.key});

  static show(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => const ModerationBottomSheet(),
      );

  @override
  Widget build(BuildContext context) {
    final moderationList = ['사용자 차단하기', '신고하기'];

    return SizedBox(
      height: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          moderationList.length,
          (index) => InkWell(
            onTap: () => Navigator.of(context).pop(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                moderationList[index],
                style: AppTextStyle.bold20.copyWith(color: AppColor.orangeFF6060),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SellStatusBottomSheet extends StatelessWidget {
  const SellStatusBottomSheet({super.key, this.curSellStatus});

  final int? curSellStatus;

  static Future<int?> show(BuildContext context, {int? curSellStatus = 0}) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => SellStatusBottomSheet(curSellStatus: curSellStatus),
      );

  @override
  Widget build(BuildContext context) {
    final sellStatusList = [...ProductSellStatus.values.where((e) => e != ProductSellStatus.shared)];

    return SafeArea(
      child: SizedBox(
        height: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            sellStatusList.length,
            (index) => InkWell(
              onTap: () => Navigator.of(context).pop(sellStatusList[index].index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  sellStatusList[index].displayValue,
                  style: AppTextStyle.bold20.copyWith(
                    color: sellStatusList[index].index == curSellStatus ? AppColor.orangeFF6060 : AppColor.black121212,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
