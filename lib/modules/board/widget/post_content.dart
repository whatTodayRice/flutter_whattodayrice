// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_whattodayrice/config/themes/app_color.dart';
// import 'package:flutter_whattodayrice/data/models/post.dart';
//
// class PostContent extends StatelessWidget {
//   const PostContent({
//     super.key,
//     required this.post,
//   });
//
//   final Post post;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 56.h,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SvgPicture.asset("assets/images/icon_author_profile.svg"),
//                 SizedBox(width: 8.w),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       post.nickname,
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
//                     ),
//                     Text(
//                       post.createdAt,
//                       style:
//                           Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11.sp, color: AppColor.grayB0B7C0),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10.h),
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   post.title,
//                   style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18.sp),
//                   overflow: TextOverflow.clip,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   post.content,
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
//                   overflow: TextOverflow.clip,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
