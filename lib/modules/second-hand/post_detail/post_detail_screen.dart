import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/utils/login_validator.dart';
import 'package:flutter_whattodayrice/common/widget/app_bottom_sheet.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/common/widget/app_snack_bar.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/widget/comment_input.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/widget/comment_item.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/bloc/post_detail_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/widget/full_image_view.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/widget/post_detail_more_button.dart';
import 'package:flutter_whattodayrice/modules/second-hand/post_detail/widget/sell_status_button.dart';
import 'package:flutter_whattodayrice/utils/extensions/date_time_extension.dart';
import 'package:flutter_whattodayrice/utils/extensions/int_extension.dart';
import 'package:flutter_whattodayrice/utils/log/logger.dart';
import 'package:go_router/go_router.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.postId});

  final String postId;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool _isCheckingLoginState = false;

  final focusNode = FocusNode();
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<PostDetailBloc>().add(PostDetailLoadRequested(postId: widget.postId));

    focusNode.addListener(() async => handleFocusChanged());
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  Future<void> handleFocusChanged() async {
    if (!focusNode.hasFocus) {
      return;
    }

    if (_isCheckingLoginState) {
      return;
    }

    _isCheckingLoginState = true;

    try {
      final isLoggedIn = LoginValidator.isUserLoggedIn();

      if (isLoggedIn != true) {
        final result = await LoginValidator.validate(context);

        if (result != true) {
          focusNode.unfocus();
          textEditingController.clear();

          return;
        }
      }
    } catch (e) {
      Log.i('댓글 입력창 에러: $e');

      return;
    } finally {
      _isCheckingLoginState = false;
    }
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
        } else if (state is PostDetailDeleteSucceed) {
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
            child: Assets.images.svg.iconLeftArrowGray.svg(fit: BoxFit.scaleDown),
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
                  child: PostDetailMoreButton.post(
                    writerId: post.userId,
                    postId: post.id,
                    nickname: post.nickname,
                    onDelete: () => context.read<PostDetailBloc>().add(const PostDetailDeleteRequested()),
                    onUserBlock: () => context.read<PostDetailBloc>().add(const PostDetailWriterBlockRequested()),
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
            final userId = getIt<UserRepository>().getUserProfileFromCache()?.id;

            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                if (post.imageUrl?.isNotEmpty == true)
                                  InkWell(
                                    onTap: () => Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => FullImageView(imageUrl: post.imageUrl!),
                                      ),
                                    ),
                                    child: CachedNetworkImage(
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
                                if (userId != post.userId && post.sellStatus == ProductSellStatus.done.index)
                                  Container(
                                    width: double.infinity,
                                    height: 400,
                                    color: AppColor.black000000.withValues(alpha: 0.7),
                                    child: Center(
                                      child: Text(
                                        '판매완료된 상품입니다.',
                                        style: AppTextStyle.regular16.copyWith(color: AppColor.whiteFFFFFF),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post.title ?? "-",
                                              style: AppTextStyle.regular16.copyWith(color: AppColor.black000000),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
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
                                          ],
                                        ),
                                      ),
                                      BlocBuilder<PostDetailBloc, PostDetailState>(
                                        buildWhen: (previous, current) => current is PostDetailLoaded,
                                        builder: (context, state) {
                                          if (state is! PostDetailLoaded) {
                                            return const SizedBox.shrink();
                                          }

                                          final post = state.post;
                                          final userId = getIt<UserRepository>().getUserProfileFromCache()?.id;

                                          final isWriter = post.userId == userId;

                                          if (isWriter != true) {
                                            return SellStatusFilterButton.normal(post.sellStatus ?? 0);
                                          }

                                          return InkWell(
                                            onTap: () async {
                                              final result = await SellStatusBottomSheet.show(
                                                context,
                                                curSellStatus: post.sellStatus,
                                              );

                                              if (result == null) {
                                                return;
                                              }

                                              context
                                                  .read<PostDetailBloc>()
                                                  .add(PostDetailSellStatusChangeRequested(statusIndex: result));
                                            },
                                            child: SellStatusFilterButton.writer(post.sellStatus ?? 0),
                                          );
                                        },
                                      ),
                                    ],
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
                              onUserBlock: () => context
                                  .read<PostDetailBloc>()
                                  .add(PostDetailWriterBlockRequested(commentIndex: index)),
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
                        textEditingController: textEditingController,
                        focusNode: focusNode,
                        onCommentCreateCallback: () =>
                            context.read<PostDetailBloc>().add(const PostDetailCreateCommentRequested()),
                        onCommentChangeCallback: () => context
                            .read<PostDetailBloc>()
                            .add(PostDetailCommentContentChangeRequested(content: textEditingController.text)),
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
