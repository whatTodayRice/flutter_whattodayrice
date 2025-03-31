import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSelectionButton extends StatelessWidget {
  const ImageSelectionButton({super.key, this.isImageAdded = false});

  final bool? isImageAdded;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final permissionStatus = await Permission.photos.request();

        // TODO 이미지 피커 구현 필요
        if (permissionStatus.isGranted == true) {}
      },
      child: Container(
        width: 60,
        height: 60,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(3), border: Border.all(color: AppColor.grayCBCBCB)),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Assets.images.imageSelection.image(width: 20, height: 20),
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
