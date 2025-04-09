import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/common/widget/app_bar_normal.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/common/widget/post_list_item.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/modules/setting/my_posts/bloc/my_post_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  final pagingController = PagingController<String, Post>(firstPageKey: '');

  @override
  void initState() {
    final bloc = context.read<MyPostBloc>();

    bloc.add(const MyPostLoadRequested());

    pagingController.addPageRequestListener((_) => bloc.add(const MyPostLoadRequested()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyPostBloc, MyPostState>(
      listener: (context, state) {
        if (state is MyPostLoaded) {
          pagingController.value = PagingState(itemList: state.myPostList, nextPageKey: state.lastDocId);
        }
      },
      child: Scaffold(
        appBar: const AppBarNormal(),
        body: BlocBuilder<MyPostBloc, MyPostState>(
          buildWhen: (previous, current) => current is MyPostLoaded,
          builder: (context, state) {
            if (state is! MyPostLoaded) {
              return const Center(child: AppLoadingIndicator());
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${state.nickname ?? "-"}님의 최근 활동',
                      style: AppTextStyle.bold20.copyWith(color: AppColor.black121212),
                    ),
                  ),
                  Text(
                    '${state.nickname ?? "-"}님이 작성한 게시글을 최신 순으로 볼 수 있어요.',
                    style: AppTextStyle.regular14.copyWith(color: AppColor.gray8C8C8C),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: PagedListView<String, Post>.separated(
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, item, index) => PostListItem(
                          onTap: () {
                            if (item.id == null) {
                              return;
                            }

                            context.pushNamed(AppRouteState.postDetail.name, pathParameters: {'id': item.id!});
                          },
                          imageUrl: item.imageUrl,
                          title: item.title,
                          price: item.price,
                          location: item.location,
                          createdAt: item.createdAt,
                          sellStatus: item.sellStatus,
                        ),
                        noItemsFoundIndicatorBuilder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 150),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    '아직 작성한 글이 없어요.',
                                    style: AppTextStyle.regular16.copyWith(color: AppColor.grayB2B2B2),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  InkWell(
                                    onTap: () => context.goNamed(AppRouteState.secondHand.name),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      height: 46,
                                      decoration: BoxDecoration(
                                          color: AppColor.orangeFF823B, borderRadius: BorderRadius.circular(23)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '게시글 보러가기',
                                            style: AppTextStyle.regular16.copyWith(color: AppColor.whiteF8F8F8),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
