import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';

class SellStatusFilterButton extends StatelessWidget {
  const SellStatusFilterButton({super.key, required this.sellStatusIndex, this.isWriter});

  final bool? isWriter;
  final int sellStatusIndex;

  factory SellStatusFilterButton.writer(int sellStatusIndex) => SellStatusFilterButton(
        isWriter: true,
        sellStatusIndex: sellStatusIndex,
      );

  factory SellStatusFilterButton.normal(int sellStatusIndex) => SellStatusFilterButton(
        sellStatusIndex: sellStatusIndex,
      );

  @override
  Widget build(BuildContext context) {
    final sellStatus = ProductSellStatus.values[sellStatusIndex];

    if (isWriter == true) {
      return Container(
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColor.grayADADAD)),
        child: Row(
          children: [
            Text(
              sellStatus.displayValue,
              style: AppTextStyle.regular14.copyWith(fontWeight: FontWeight.w600, color: AppColor.black474747),
            ),
            const SizedBox(width: 8),
            Assets.images.svg.iconDownArrowGray.svg(),
          ],
        ),
      );
    }

    if (sellStatus == ProductSellStatus.isOngoing) {
      return const SizedBox.shrink();
    }

    final borderColor = switch (sellStatus) {
      ProductSellStatus.done => AppColor.grayADADAD,
      ProductSellStatus.reserved => AppColor.orangeFF823B,
      _ => null,
    };

    final containerColor = switch (sellStatus) {
      ProductSellStatus.done => AppColor.whiteF1F1F1,
      ProductSellStatus.reserved => AppColor.orangeFFF6F0,
      _ => null,
    };

    final textColor = switch (sellStatus) {
      ProductSellStatus.done => AppColor.grayADADAD,
      ProductSellStatus.reserved => AppColor.orangeFF823B,
      _ => null,
    };

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: borderColor != null ? Border.all(color: borderColor) : null,
        color: containerColor,
      ),
      child: Center(
        child: Text(
          sellStatus.displayValue,
          style: AppTextStyle.regular14.copyWith(fontWeight: FontWeight.w600, color: textColor),
        ),
      ),
    );
  }
}
