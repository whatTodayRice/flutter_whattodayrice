import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/widget/app_bottom_sheet.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/common/widget/app_snack_bar.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:flutter_whattodayrice/modules/board/comment/widget/comment_input.dart';
import 'package:flutter_whattodayrice/modules/board/comment/widget/comment_item.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/bloc/post_detail_bloc.dart';
import 'package:flutter_whattodayrice/utils/extensions/date_time_extension.dart';
import 'package:flutter_whattodayrice/utils/extensions/int_extension.dart';
import 'package:go_router/go_router.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.postId});

  final String postId;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final FocusNode commentFocusNode = FocusNode();
  final TextEditingController commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<PostDetailBloc>().add(PostDetailLoadRequested(postId: widget.postId));
  }

  @override
  void dispose() {
    commentTextController.dispose();
    commentFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostDetailBloc, PostDetailState>(
      listener: (context, state) {
        final goRouter = GoRouter.of(context);
        final bloc = context.read<PostDetailBloc>();
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        if (state is PostDetailUserBlockedSucceed) {
          if (state.message != null) {
            scaffoldMessenger.showSnackBar(AppSnackBar.text(state.message!));
          }

          if (state.isPost == true) {
            goRouter.pop(true);

            return;
          }

          bloc.add(PostDetailLoadRequested(postId: widget.postId));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => context.pop(),
            child: Assets.images.svg.iconRightArrowGray.svg(fit: BoxFit.scaleDown),
          ),
          actions: [
            BlocBuilder<PostDetailBloc, PostDetailState>(
              buildWhen: (previous, current) => current is PostDetailLoaded,
              builder: (context, state) {
                if (state is! PostDetailLoaded) {
                  return const SizedBox.shrink();
                }

                final post = state.post;

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () async {
                      final goRouter = GoRouter.of(context);

                      final userId = getIt<UserRepository>().getUserProfileFromCache()?.id;

                      if (userId == null) {
                        return;
                      }

                      bool? result;

                      if (userId == post.userId) {
                        final bottomSheetResult = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useRootNavigator: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => AppBottomSheet(
                            asset: Assets.images.png.iconDeleteRed.image(width: 24, height: 24),
                            content: '삭제하기',
                            onTap: () => Navigator.of(context).pop(true),
                          ),
                        );

                        if (bottomSheetResult != true) {
                          return;
                        }

                        result = await AppDefaultDialog.show(
                          context,
                          title: '게시글을 삭제하시겠어요?',
                          content: '삭제한 게시글은 되돌릴 수 없어요.',
                          cancelButtonText: '취소',
                          confirmButtonText: '삭제',
                          onConfirm: () => Navigator.of(context).pop(true),
                          confirmButtonTextColor: AppColor.orangeFF6060,
                        );

                        if (result != true) {
                          return;
                        }

                        goRouter.pop(true);

                        return;
                      }

                      final bottomSheetResult = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => AppBottomSheet(
                          asset: Assets.images.svg.iconReport.svg(width: 24, height: 24),
                          content: '삭제하기',
                          onTap: () => Navigator.of(context).pop(true),
                        ),
                      );

                      if (bottomSheetResult != true) {
                        return;
                      }

                      // TODO: 신고 기능 구현
                    },
                    child: Assets.images.svg.iconMore.svg(width: 24, height: 24),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<PostDetailBloc, PostDetailState>(
          buildWhen: (previous, current) => current is PostDetailLoaded,
          builder: (context, state) {
            if (state is! PostDetailLoaded) {
              return const Center(child: AppLoadingIndicator());
            }

            final post = state.post;

            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            if (post.imageUrl?.isNotEmpty == true)
                              CachedNetworkImage(
                                imageUrl: post.imageUrl!,
                                width: double.infinity,
                                height: 400,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, progress) =>
                                    const Center(child: AppLoadingIndicator()),
                                errorWidget: (context, url, error) => Center(
                                  child: Text(
                                    '이미지를 불러오는 도중에 문제가 발생했어요. 잠시 후 다시 시도해주세요.',
                                    style: AppTextStyle.regular16.copyWith(color: AppColor.orangeFF823B),
                                  ),
                                ),
                              )
                            else
                              SizedBox(
                                width: double.infinity,
                                height: 400,
                                child: Center(
                                  child: Text(
                                    '이미지를 불러오는 도중에 문제가 발생했어요. 잠시 후 다시 시도해주세요.',
                                    style: AppTextStyle.regular16.copyWith(color: AppColor.orangeFF823B),
                                  ),
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.title ?? "-",
                                    style: AppTextStyle.regular16.copyWith(color: AppColor.black000000),
                                  ),
                                  const SizedBox(height: 4),
                                  if (post.sellStatus != ProductSellStatus.shared.index)
                                    Text(
                                      "${post.price?.getPriceStandardFormat()}원",
                                      style: AppTextStyle.bold18.copyWith(color: AppColor.black000000),
                                    )
                                  else
                                    Text(
                                      "무료 나눔해요!",
                                      style: AppTextStyle.bold18.copyWith(color: AppColor.orangeFF7324),
                                    ),
                                  const SizedBox(height: 8),
                                  Text(
                                    post.createdAt.getRelativeDateFormat(),
                                    style: AppTextStyle.regular11.copyWith(color: AppColor.gray727272),
                                  ),
                                  const Divider(color: AppColor.grayF2F3F6),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
                                    child: Text(
                                      post.content ?? "-",
                                      style: AppTextStyle.regular14.copyWith(color: AppColor.black121212),
                                    ),
                                  ),
                                  Text(
                                    '거래 희망 장소',
                                    style: AppTextStyle.bold14.copyWith(color: AppColor.black121212),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: AppColor.grayDCDCDC),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(
                                      post.location ?? "-",
                                      style: AppTextStyle.regular14.copyWith(color: AppColor.black121212),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(child: Divider(color: AppColor.whiteF8F8F8, thickness: 10)),
                      if (post.comments.isNotEmpty)
                        SliverList.builder(
                          itemCount: post.comments.length,
                          itemBuilder: (context, index) {
                            final comment = post.comments[index];

                            return CommentItem(
                              comment: comment,
                              commentIndex: index,
                              onDelete: () =>
                                  context.read<PostDetailBloc>().add(PostDetailDeleteRequested(commentId: comment.id)),
                            );
                          },
                        )
                      else
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 150),
                            child: Center(
                              child: Text(
                                '아직 댓글이 없어요.\n가장 먼저 댓글을 남겨보세요!',
                                style: AppTextStyle.regular16.copyWith(color: AppColor.grayB2B2B2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                BlocBuilder<PostDetailBloc, PostDetailState>(
                  buildWhen: (previous, current) => current is PostDetailCommentValidationChecked,
                  builder: (context, state) {
                    bool isEnabled = false;

                    if (state is PostDetailCommentValidationChecked) {
                      isEnabled = state.isValid;
                    }

                    return SafeArea(
                      child: CommentInput(
                        textEditingController: commentTextController,
                        focusNode: commentFocusNode,
                        onCommentCreateCallback: () =>
                            context.read<PostDetailBloc>().add(const PostDetailCreateCommentRequested()),
                        onCommentChangeCallback: () => context
                            .read<PostDetailBloc>()
                            .add(PostDetailCommentContentChangeRequested(content: commentTextController.text)),
                        isButtonEnabled: isEnabled,
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
