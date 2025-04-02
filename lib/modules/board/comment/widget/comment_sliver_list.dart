import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/modules/board/comment/bloc/comment_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CommentSliverList extends StatefulWidget {
  const CommentSliverList({super.key});

  @override
  State<CommentSliverList> createState() => _CommentSliverListState();
}

class _CommentSliverListState extends State<CommentSliverList> {
  late final CommentBloc commentBloc;
  final PagingController<int, Post> commentPagingController = PagingController<int, Post>(firstPageKey: 1);

  @override
  void initState() {
    commentBloc = context.read<CommentBloc>();

    commentPagingController.addPageRequestListener(
      (_) {
        commentBloc.add(const CommentListLoadRequested());
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        switch (state) {
          case CommentError():
            break;
          case CommentListLoaded():
            commentPagingController.value = PagingState(itemList: state.comments);
        }
      },
      child: SliverPadding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        sliver: PagedSliverList<int, Post>.separated(
          pagingController: commentPagingController,
          builderDelegate: PagedChildBuilderDelegate(
            firstPageErrorIndicatorBuilder: (_) => const SizedBox.shrink(),
            newPageErrorIndicatorBuilder: (_) => const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (_) => const SizedBox.shrink(),
            noItemsFoundIndicatorBuilder: (_) => const Center(child: Text('아직 작성된 게시글이 없어요.')),
            itemBuilder: (context, comment, index) {
              return SizedBox();
            },
          ),
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 10.h,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColor.whiteF8F8F8)),
              ),
            );
          },
        ),
      ),
    );
  }
}
