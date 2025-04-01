import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

enum PostSellStatus {
  sellDone('판매완료'),
  shared('나눔해요'),
  reserved('예약중');

  final String displayValue;

  const PostSellStatus(this.displayValue);
}

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
        data: PostSellStatus.sellDone.displayValue,
        badgeColor: AppColor.grayA6A6A6,
        textColor: AppColor.whiteFDFDFD,
      );

  factory PostSellStatusBadge.shared() => PostSellStatusBadge(
        data: PostSellStatus.shared.displayValue,
        badgeColor: AppColor.orangeFFF0E8,
        textColor: AppColor.orangeFF823B,
      );

  factory PostSellStatusBadge.reserved() => PostSellStatusBadge(
        data: PostSellStatus.reserved.displayValue,
        badgeColor: AppColor.orangeFF9559,
        textColor: AppColor.white1,
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
