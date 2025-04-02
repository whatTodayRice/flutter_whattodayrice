import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/widget/app_bottom_sheet.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/common/widget/app_snack_bar.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:go_router/go_router.dart';

class PostDetailMoreButton extends StatelessWidget {
  const PostDetailMoreButton(
      {super.key, this.postId, this.commentId, this.isPost, this.writerId, this.onDelete, this.size});

  final bool? isPost;
  final String? postId;
  final String? commentId;
  final int? writerId;
  final VoidCallback? onDelete;
  final double? size;

  factory PostDetailMoreButton.post({int? writerId, String? postId, VoidCallback? onDelete}) => PostDetailMoreButton(
        isPost: true,
        writerId: writerId,
        postId: postId,
        onDelete: onDelete,
        size: 24,
      );

  factory PostDetailMoreButton.comment({int? writerId, String? postId, String? commentId, VoidCallback? onDelete}) =>
      PostDetailMoreButton(
        isPost: false,
        writerId: writerId,
        postId: postId,
        commentId: commentId,
        onDelete: onDelete,
        size: 20,
      );

  @override
  Widget build(BuildContext context) {
    final postTypeDisplayValue = isPost == true ? '게시글' : '댓글';

    return InkWell(
      onTap: () async {
        final goRouter = GoRouter.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        final userId = getIt<UserRepository>().getUserProfileFromCache()?.id;

        if (userId == null) {
          return;
        }

        // TODO: 로그인 하지 않은 유저에 대한 처리 필요할 지 검토 필요

        bool? result;

        if (userId == writerId) {
          final bottomSheetResult = await AppBottomSheet.show(
            context,
            asset: Assets.images.png.iconDeleteRed.image(width: 24, height: 24),
            content: '삭제하기',
            onTap: () => Navigator.of(context).pop(true),
          );

          if (bottomSheetResult != true) {
            return;
          }

          result = await AppDefaultDialog.show(
            context,
            title: '$postTypeDisplayValue을 삭제하시겠어요?',
            content: '삭제한 $postTypeDisplayValue은 되돌릴 수 없어요.',
            cancelButtonText: '취소',
            confirmButtonText: '삭제',
            onConfirm: () => Navigator.of(context).pop(true),
            confirmButtonTextColor: AppColor.orangeFF6060,
          );

          if (result != true) {
            return;
          }

          onDelete?.call();

          return;
        }

        final bottomSheetResult = await AppBottomSheet.show(
          context,
          asset: Assets.images.svg.iconReport.svg(width: 24, height: 24),
          content: '신고하기',
          onTap: () => Navigator.of(context).pop(true),
        );

        if (bottomSheetResult != true) {
          return;
        }

        final reportResult = await goRouter.pushNamed(AppRouteState.report.name, queryParameters: {
          'postId': postId,
          'commentId': commentId,
        });

        if (reportResult != true) {
          return;
        }

        scaffoldMessenger.showSnackBar(AppSnackBar.text('$postTypeDisplayValue 신고가 완료됐습니다.'));
      },
      child: Assets.images.svg.iconMore.svg(width: size, height: size),
    );
  }
}
