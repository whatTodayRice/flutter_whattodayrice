import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

class PriceTypeButton extends StatelessWidget {
  const PriceTypeButton({super.key, required this.data, this.isSelected});

  final String data;
  final bool? isSelected;

  factory PriceTypeButton.sell({bool? isSelected}) => PriceTypeButton(data: '판매해요', isSelected: isSelected);
  factory PriceTypeButton.share({bool? isSelected}) => PriceTypeButton(data: '나눔해요', isSelected: isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isSelected == true ? AppColor.gray515151 : AppColor.whiteF4F4F4,
      ),
      child: Text(
        data,
        style: AppTextStyle.regular11.copyWith(color: isSelected == true ? AppColor.grayEAEAEA : AppColor.gray636363),
      ),
    );
  }
}
