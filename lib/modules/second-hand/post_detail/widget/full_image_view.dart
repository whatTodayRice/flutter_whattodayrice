import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

class FullImageView extends StatelessWidget {
  const FullImageView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.black000000,
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Assets.images.svg.iconOut.svg(width: 24, height: 24),
          ),
        ],
      ),
      backgroundColor: AppColor.black000000,
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) => const Center(child: AppLoadingIndicator()),
            errorWidget: (context, url, error) => Center(
              child: Text(
                '이미지를 불러오는 도중에 문제가 발생했어요. 잠시 후 다시 시도해주세요.',
                style: AppTextStyle.regular16.copyWith(color: AppColor.orangeFF823B),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
