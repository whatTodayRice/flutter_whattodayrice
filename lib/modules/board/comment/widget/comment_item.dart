import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whattodayrice/common/widget/app_bottom_sheet.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/models/comment.dart';
import 'package:flutter_whattodayrice/modules/board/comment/bloc/comment_bloc.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    required this.comment,
    required this.commentIndex,
  });

  final Comment comment;
  final int commentIndex;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  late final CommentBloc commentBloc;

  @override
  void initState() {
    commentBloc = context.read<CommentBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          widget.comment.nickname,

                          /// 작성자인지 체크하는 로직 추가
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontSize: 13.sp,
                                color: AppColor.black121212,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          widget.comment.content,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 13.sp,
                                color: AppColor.black121212,
                              ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.comment.createdAt,
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
                        onTap: () => showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          useRootNavigator: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => AppBottomSheet(
                            assetPath: "assets/images/icon_삭제.svg",
                            content: "삭제하기",
                            onTap: () {
                              Navigator.of(context).pop();
                              AppDefaultDialog.show(
                                context,
                                title: "댓글을 삭제하시겠어요?",
                                content: "삭제한 댓글은 되돌릴 수 없어요.",
                                onConfirm: () => commentBloc.add(
                                  CommentDeleteRequested(
                                    commentIndex: widget.commentIndex,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
    );
  }
}
