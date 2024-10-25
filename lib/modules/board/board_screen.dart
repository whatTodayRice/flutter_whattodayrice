import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_post_type.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/modules/board/bloc/post_bloc.dart';
import 'package:flutter_whattodayrice/modules/board/widget/FAB/expanded_fab.dart';
import 'package:flutter_whattodayrice/modules/board/widget/FAB/fab_item.dart';
import 'package:flutter_whattodayrice/modules/board/widget/FAB/fab_main.dart';
import 'package:flutter_whattodayrice/modules/board/widget/board_tab_bar.dart';
import 'package:flutter_whattodayrice/modules/board/widget/post_list_view.dart';
import 'package:flutter_whattodayrice/modules/home/bloc/home_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> with SingleTickerProviderStateMixin {
  late final PostBloc postBloc;
  late final TabController tabController;

  final PagingController<int, Post> freePostPagingController = PagingController<int, Post>(firstPageKey: 1);
  final PagingController<int, Post> questionPostPagingController = PagingController<int, Post>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    postBloc = context.read<PostBloc>();

    tabController = TabController(length: 2, vsync: this);

    freePostPagingController.addPageRequestListener(
      (_) => postBloc.add(const FreePostListLoadRequested()),
    );
    questionPostPagingController.addPageRequestListener(
      (_) => postBloc.add(const QuestionPostListLoadRequested()),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    freePostPagingController.dispose();
    questionPostPagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        switch (state) {
          case PostError():
            break;
          case FreePostLoaded():
            freePostPagingController.value = PagingState(itemList: state.itemList);
            break;
          case QuestionPostLoaded():
            questionPostPagingController.value = PagingState(itemList: state.itemList);
            break;
          default:
            break;
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text("행복 게시판", style: Theme.of(context).textTheme.titleMedium!),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: BoardTabBar(tabController: tabController),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        PostListView(
                          postType: PostType.free,
                          pagingController: freePostPagingController,
                          onRefresh: () {
                            postBloc.add(const FreePostListRefreshRequested());
                          },
                        ),
                        PostListView(
                          postType: PostType.question,
                          pagingController: questionPostPagingController,
                          onRefresh: () {
                            postBloc.add(const QuestionPostListRefreshRequested());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              bool isExpanded = false;

              if (state is HomeLoaded) {
                isExpanded = state.isBoardFABExpanded!;
              }

              return isExpanded
                  ? Positioned.fill(
                      child: GestureDetector(
                        onTap: () => context.read<HomeBloc>().add(
                              const HomeBoardScreenFabToggleRequested(isExpanded: false),
                            ),
                        child: Container(color: Colors.black54),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              bool isExpanded = false;

              if (state is HomeLoaded) {
                isExpanded = state.isBoardFABExpanded!;
              }

              return Align(
                alignment: Alignment.bottomRight,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Material(
                    color: Colors.transparent,
                    child: isExpanded
                        ? ExpandedFab(
                            fabItems: [
                              FABItem(
                                assetPath: "assets/images/icon_free.svg",
                                mainButtonText: "${PostType.free.title}게시판",
                              ),
                              FABItem(
                                assetPath: "assets/images/icon_question.svg",
                                mainButtonText: "${PostType.question.title}게시판",
                              ),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.only(right: 20.w, bottom: 26.h),
                            child: const BoardMainFAB(),
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
