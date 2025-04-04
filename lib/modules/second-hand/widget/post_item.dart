import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/image_preview.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/post_sell_status_badge.dart';
import 'package:flutter_whattodayrice/utils/extensions/date_time_extension.dart';
import 'package:flutter_whattodayrice/utils/extensions/int_extension.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    this.onTap,
    this.imageUrl,
    this.title,
    this.price,
    this.location,
    this.sellStatus,
    this.createdAt,
  });

  final VoidCallback? onTap;
  final String? imageUrl;
  final String? title;
  final String? location;
  final int? price;
  final int? sellStatus;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 125,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.grayF2F3F6))),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? '',
                width: 92,
                height: 92,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => const PreviewErrorImage(size: 92),
                errorWidget: (context, url, error) => const PreviewErrorImage(size: 92),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "-",
                  style: AppTextStyle.regular14.copyWith(color: AppColor.black000000),
                ),
                const SizedBox(height: 8),
                if (sellStatus != ProductSellStatus.shared.index)
                  Row(
                    children: [
                      Text(
                        '${price?.getPriceStandardFormat() ?? "-"}원',
                        style: AppTextStyle.bold14.copyWith(color: AppColor.black000000),
                      ),
                      const SizedBox(width: 6),
                      if (sellStatus == ProductSellStatus.reserved.index)
                        PostSellStatusBadge.reserved()
                      else if (sellStatus == ProductSellStatus.done.index)
                        PostSellStatusBadge.sellDone()
                    ],
                  )
                else
                  PostSellStatusBadge.shared(),
                const Spacer(),
                Text(
                  '${location ?? '행복 기숙사'}  •  ${createdAt?.getRelativeDateFormat()}',
                  style: AppTextStyle.regular11.copyWith(color: AppColor.gray727272),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
