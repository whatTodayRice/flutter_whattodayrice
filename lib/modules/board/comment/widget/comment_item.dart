import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/utils/extensions/date_time_extension.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
    required this.commentIndex,
    this.onDelete,
  });

  final Post comment;
  final int commentIndex;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/images/icon_author_profile.svg", width: 30.w, height: 30.h),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.nickname ?? "-",

                            /// 작성자인지 체크하는 로직 추가
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontSize: 13.sp,
                                  color: AppColor.black121212,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            comment.content ?? "-",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 13.sp,
                                  color: AppColor.black121212,
                                ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            comment.createdAt.getRelativeDateFormat(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.grayB0B7C0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final result = await AppDefaultDialog.show(
                              context,
                              title: "댓글을 삭제하시겠어요?",
                              content: "삭제한 댓글은 되돌릴 수 없어요.",
                              cancelButtonText: '취소',
                              confirmButtonText: '삭제',
                              onConfirm: () => Navigator.of(context).pop(true),
                            );

                            if (result != true) {
                              return;
                            }

                            onDelete?.call();
                          },
                          child: SvgPicture.asset("assets/images/icon_더보기.svg", width: 20.w, height: 20.h),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
