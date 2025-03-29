import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/gen/assets.gen.dart';

class ImageSelectionButton extends StatelessWidget {
  const ImageSelectionButton({super.key, this.isImageAdded = false});

  final bool? isImageAdded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), border: Border.all(color: AppColor.grayCBCBCB)),
      child: Center(
        child: Column(
          children: [
            Assets.images.imageAddtion.svg(width: 20, height: 20),
            const SizedBox(height: 4),
            Text(
              '${isImageAdded == true ? 1 : 0}/1',
              style: AppTextStyle.regular11.copyWith(color: AppColor.grayCBCBCB),
            ),
          ],
        ),
      ),
    );
  }
}
