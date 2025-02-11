import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_post_type.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/modules/board/widget/post_card.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PostListView extends StatelessWidget {
  const PostListView({
    super.key,
    required this.postType,
    required this.pagingController,
    required this.onRefresh,
  });

  final PostType postType;
  final PagingController<int, Post> pagingController;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      triggerMode: IndicatorTriggerMode.anywhere,
      builder: (BuildContext context, Widget child, controller) {
        return Stack(
          children: [
            child,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: controller.value.clamp(0.0, 1.0),
                duration: const Duration(milliseconds: 300),
                child: Container(
                  height: 80 * controller.value.clamp(0.0, 1.0),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: const CustomSpinner(),
                ),
              ),
            ),
          ],
        );
      },
      child: PagedListView<int, Post>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Post>(
          firstPageProgressIndicatorBuilder: (_) => const Center(child: CustomSpinner()),
          newPageProgressIndicatorBuilder: (_) => const Center(child: CustomSpinner()),
          firstPageErrorIndicatorBuilder: (_) => const SizedBox.shrink(),
          newPageErrorIndicatorBuilder: (_) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (_) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (_) => const Center(child: Text('아직 작성된 게시글이 없어요.')),
          itemBuilder: (context, post, index) {
            return GestureDetector(
              onTap: () => context.pushNamed(AppRouteState.postDetail.name, extra: post),
              child: PostCard(post: post),
            );
          },
        ),
      ),
    );
  }
}
