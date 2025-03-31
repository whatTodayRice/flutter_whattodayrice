import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';

class SelectedImage extends StatelessWidget {
  const SelectedImage({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl?.isNotEmpty != true) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: CachedNetworkImage(imageUrl: imageUrl!, width: 60, height: 60),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Assets.images.iconDelete.svg(width: 18, height: 18),
        )
      ],
    );
  }
}
