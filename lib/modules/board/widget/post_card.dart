// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_whattodayrice/config/themes/app_color.dart';
// import 'package:flutter_whattodayrice/data/models/post.dart';
//
// class PostCard extends StatelessWidget {
//   const PostCard({
//     super.key,
//     required this.post,
//   });
//
//   final Post post;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 82.h,
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: AppColor.grayE6E6E6)),
//       ),
//       margin: EdgeInsets.only(top: 20.h),
//       padding: EdgeInsets.only(bottom: 12.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ///Title
//           Text(
//             post.title,
//             style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//           ),
//           SizedBox(height: 8.h),
//
//           /// Content
//           Text(
//             post.content,
//             style: Theme.of(context).textTheme.bodySmall,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//           ),
//
//           const Spacer(),
//
//           /// Bottom
//           Row(
//             children: [
//               Text(
//                 "${post.nickname} | ${post.createdAt}",
//                 style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11, color: AppColor.gray949494),
//               ),
//               const Spacer(),
//               SvgPicture.asset("assets/images/icon_댓글.svg", width: 14.w, height: 14.h),
//               SizedBox(width: 5.w),
//               Text(
//                 "${post?.commentCount ?? 0}",
//                 style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11, color: AppColor.gray949494),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
