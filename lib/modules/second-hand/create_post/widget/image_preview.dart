import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl?.isNotEmpty != true) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) => const PreviewErrorImage(size: 100),
        errorWidget: (context, url, error) => const PreviewErrorImage(size: 100),
      ),
    );
  }
}

class PreviewErrorImage extends StatelessWidget {
  const PreviewErrorImage({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.grayDCDCDC),
      width: size,
      height: size,
    );
  }
}
