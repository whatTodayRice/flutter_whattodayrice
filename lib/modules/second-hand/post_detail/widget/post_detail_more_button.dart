import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/utils/login_validator.dart';
import 'package:flutter_whattodayrice/common/widget/app_bottom_sheet.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/common/widget/app_snack_bar.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:go_router/go_router.dart';

class PostDetailMoreButton extends StatelessWidget {
  const PostDetailMoreButton({
    super.key,
    this.postId,
    this.commentId,
    this.isPost,
    this.writerId,
    this.onDelete,
    this.onUserBlock,
    this.size,
    this.nickname,
  });

  final bool? isPost;
  final String? postId;
  final String? commentId;
  final int? writerId;
  final VoidCallback? onDelete;
  final VoidCallback? onUserBlock;
  final double? size;
  final String? nickname;

  factory PostDetailMoreButton.post({
    int? writerId,
    String? postId,
    String? nickname,
    VoidCallback? onDelete,
    VoidCallback? onUserBlock,
  }) =>
      PostDetailMoreButton(
        isPost: true,
        writerId: writerId,
        postId: postId,
        onDelete: onDelete,
        onUserBlock: onUserBlock,
        nickname: nickname,
        size: 24,
      );

  factory PostDetailMoreButton.comment({
    int? writerId,
    String? postId,
    String? commentId,
    String? nickname,
    VoidCallback? onDelete,
    VoidCallback? onUserBlock,
  }) =>
      PostDetailMoreButton(
        isPost: false,
        writerId: writerId,
        postId: postId,
        commentId: commentId,
        onDelete: onDelete,
        onUserBlock: onUserBlock,
        nickname: nickname,
        size: 20,
      );

  @override
  Widget build(BuildContext context) {
    final postTypeDisplayValue = isPost == true ? '게시글' : '댓글';

    return InkWell(
      onTap: () async {
        final goRouter = GoRouter.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        final isUserLoggedIn = LoginValidator.isUserLoggedIn();

        if (isUserLoggedIn != true) {
          final result = await LoginValidator.validate(context);

          if (result != true) {
            return;
          }
        }

        final userId = getIt<UserRepository>().getUserProfileFromCache()?.id;

        bool? result;

        if (userId != writerId) {
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

        final bottomSheetResult = await ModerationBottomSheet.show(context);

        if (bottomSheetResult == null) {
          return;
        }

        if (bottomSheetResult == 0) {
          final blockResult = await AppDefaultDialog.show(
            context,
            title: '$nickname님을 차단하시겠어요?',
            content: '$nickname님이 쓴 글은 앞으로 볼 수 없어요.',
            cancelButtonText: '취소',
            confirmButtonText: '차단',
            confirmButtonTextColor: AppColor.orangeFF6060,
            onConfirm: () => Navigator.of(context).pop(true),
          );

          if (blockResult != true) {
            return;
          }

          onUserBlock?.call();
        } else if (bottomSheetResult == 1) {
          final reportResult = await goRouter.pushNamed(AppRouteState.report.name, queryParameters: {
            'postId': postId,
            'commentId': commentId,
          });

          if (reportResult != true) {
            return;
          }

          scaffoldMessenger.showSnackBar(AppSnackBar.text('$postTypeDisplayValue 신고가 완료됐습니다.'));
        }
      },
      child: Assets.images.svg.iconMore.svg(width: size, height: size),
    );
  }
}
