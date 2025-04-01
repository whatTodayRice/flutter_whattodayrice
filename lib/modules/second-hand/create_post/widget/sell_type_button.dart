import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';

class SellTypeButton extends StatelessWidget {
  const SellTypeButton({super.key, this.onTap, required this.data, this.selectedIndex, required this.type});

  final VoidCallback? onTap;
  final String data;
  final int? selectedIndex;
  final ProductPriceType type;

  factory SellTypeButton.sell({VoidCallback? onTap, int? selectedIndex}) =>
      SellTypeButton(data: '판매해요', onTap: onTap, type: ProductPriceType.sell, selectedIndex: selectedIndex);
  factory SellTypeButton.share({VoidCallback? onTap, int? selectedIndex}) =>
      SellTypeButton(data: '나눔해요', onTap: onTap, type: ProductPriceType.share, selectedIndex: selectedIndex);

  @override
  Widget build(BuildContext context) {
    final containerColor = selectedIndex == type.index ? AppColor.gray515151 : AppColor.whiteF4F4F4;
    final textColor = selectedIndex == type.index ? AppColor.grayEAEAEA : AppColor.gray636363;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: containerColor),
        child: Text(
          data,
          style: AppTextStyle.regular11.copyWith(color: textColor),
        ),
      ),
    );
  }
}
