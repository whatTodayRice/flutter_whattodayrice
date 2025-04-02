// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_whattodayrice/config/themes/app_color.dart';
// import 'package:flutter_whattodayrice/data/models/post.dart';
// import 'package:flutter_whattodayrice/modules/board/comment/bloc/comment_bloc.dart';
// import 'package:flutter_whattodayrice/modules/board/comment/widget/comment_input.dart';
// import 'package:flutter_whattodayrice/modules/board/comment/widget/comment_sliver_list.dart';
// import 'package:go_router/go_router.dart';
//
// class PostDetailScreen extends StatefulWidget {
//   const PostDetailScreen({super.key, required this.post});
//
//   final Post post;
//
//   @override
//   State<PostDetailScreen> createState() => _PostDetailScreenState();
// }
//
// class _PostDetailScreenState extends State<PostDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             GestureDetector(
//               onTap: () => context.pop(),
//               child: SvgPicture.asset("assets/images/icon_뒤로가기.svg", width: 24, height: 24),
//             ),
//             const Spacer(),
//             GestureDetector(onTap: () {}, child: SvgPicture.asset("assets/images/icon_더보기.svg", width: 24, height: 24)),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: CustomScrollView(
//               slivers: [
//                 // SliverToBoxAdapter(child: PostContent(post: widget.post)),
//                 SliverToBoxAdapter(child: Container(height: 10.h, color: AppColor.white1)),
//                 const CommentsCountRow(),
//                 SliverToBoxAdapter(child: SizedBox(height: 10.h)),
//                 const CommentSliverList(),
//               ],
//             ),
//           ),
//           const SafeArea(child: CommentInput()),
//         ],
//       ),
//     );
//   }
// }
//
// class CommentsCountRow extends StatelessWidget {
//   const CommentsCountRow({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CommentBloc, CommentState>(
//       buildWhen: (_, current) => current is CommentListLoaded,
//       builder: (context, state) {
//         if (state is! CommentListLoaded) {
//           return const SliverToBoxAdapter(child: SizedBox.shrink());
//         }
//
//         final int commentListLength = state.comments.length;
//
//         return SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 16, left: 16),
//             child: RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: '댓글 ',
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                           color: AppColor.black121212,
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   TextSpan(
//                     text: commentListLength.toString(),
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                           color: AppColor.orangeFF823B,
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
