import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';

class PostSellStatusBadge extends StatelessWidget {
  const PostSellStatusBadge({
    super.key,
    required this.data,
    required this.badgeColor,
    required this.textColor,
  });

  final String data;
  final Color badgeColor;
  final Color textColor;

  factory PostSellStatusBadge.sellDone() => PostSellStatusBadge(
        data: ProductSellStatus.done.displayValue,
        badgeColor: AppColor.grayA6A6A6,
        textColor: AppColor.whiteFDFDFD,
      );

  factory PostSellStatusBadge.shared() => PostSellStatusBadge(
        data: ProductSellStatus.shared.displayValue,
        badgeColor: AppColor.orangeFFF0E8,
        textColor: AppColor.orangeFF823B,
      );

  factory PostSellStatusBadge.reserved() => PostSellStatusBadge(
        data: ProductSellStatus.reserved.displayValue,
        badgeColor: AppColor.orangeFF9559,
        textColor: AppColor.whiteF8F8F8,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: badgeColor),
      child: Text(
        data,
        style: AppTextStyle.regular11.copyWith(color: textColor),
      ),
    );
  }
}
