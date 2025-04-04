import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/modules/second-hand/bloc/second_hand_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/create_post_button.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/post_item.dart';
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
