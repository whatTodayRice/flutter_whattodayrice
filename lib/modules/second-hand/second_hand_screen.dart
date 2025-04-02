import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/modules/second-hand/bloc/second_hand_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/image_preview.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/post_sell_status_badge.dart';
import 'package:flutter_whattodayrice/utils/extensions/date_time_extension.dart';
import 'package:flutter_whattodayrice/utils/extensions/int_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SecondHandScreen extends StatefulWidget {
  const SecondHandScreen({super.key});

  @override
  State<SecondHandScreen> createState() => _SecondHandScreenState();
}

class _SecondHandScreenState extends State<SecondHandScreen> {
  final pagingController = PagingController<String, Post>(firstPageKey: '');

  @override
  void initState() {
    super.initState();

    pagingController.addPageRequestListener(
      (_) => context.read<SecondHandBloc>().add(const SecondHandLoadRequested()),
    );
  }

  void _onRefresh() {
    context.read<SecondHandBloc>().add(const SecondHandRefreshRequested());
    pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecondHandBloc, SecondHandState>(
      listener: (context, state) {
        if (state is SecondHandLoaded) {
          pagingController.value = PagingState(itemList: state.itemList, nextPageKey: state.nextPageKey);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('행복나눔거래', style: AppTextStyle.bold16.copyWith(color: AppColor.black000000)),
          centerTitle: false,
        ),
        floatingActionButton: BlocBuilder<SecondHandBloc, SecondHandState>(
          buildWhen: (previous, current) => current is SecondHandLoaded,
          builder: (context, state) {
            bool isNoItems = false;

            if (state is SecondHandLoaded) {
              isNoItems = state.itemList.isEmpty;
            }

            if (isNoItems) {
              return const SizedBox.shrink();
            }

            return CreatePostButton(onRefresh: () => _onRefresh());
          },
        ),
        body: RefreshIndicator(
          onRefresh: () async => _onRefresh(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: [
                PagedSliverList<String, Post>(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) => PostItem(
                      onTap: () async {
                        if (item.id == null) {
                          return;
                        }

                        final goRouter = GoRouter.of(context);

                        final result = await goRouter.pushNamed(
                          AppRouteState.postDetail.name,
                          pathParameters: {'id': item.id!},
                        );

                        if (result != true) {
                          return;
                        }

                        _onRefresh();
                      },
                      imageUrl: item.imageUrl,
                      title: item.title,
                      price: item.price,
                      location: item.location,
                      createdAt: item.createdAt,
                      sellStatus: item.sellStatus,
                    ),
                    newPageProgressIndicatorBuilder: (context) => const Center(child: AppLoadingIndicator()),
                    noItemsFoundIndicatorBuilder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '아직 게시글이 없습니다.\n지금 첫 거래를 시작해보세요!\n중고 물건을 나누며 가치를 만들어 가요:)',
                          style: AppTextStyle.regular18.copyWith(color: AppColor.gray8C8C8C),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        CreatePostButton(onRefresh: () => _onRefresh()),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreatePostButton extends StatelessWidget {
  const CreatePostButton({
    super.key,
    this.onRefresh,
  });

  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await context.pushNamed(AppRouteState.createPost.name);

        if (result != true) {
          return;
        }

        onRefresh?.call();
      },
      child: Container(
        width: 100,
        height: 46,
        decoration: BoxDecoration(color: AppColor.orangeFF823B, borderRadius: BorderRadius.circular(23)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.iconCreatePostFab.svg(),
            const SizedBox(width: 6),
            Text(
              '글쓰기',
              style: AppTextStyle.regular16.copyWith(color: AppColor.whiteF8F8F8),
            ),
          ],
        ),
      ),
    );
  }
}

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
                  '${location ?? '행복 기숙사'}  •  ${createdAt.getRelativeDateFormat()}',
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
