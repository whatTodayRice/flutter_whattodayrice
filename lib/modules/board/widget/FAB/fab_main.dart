import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/modules/home/bloc/home_bloc.dart';

class BoardMainFAB extends StatelessWidget {
  const BoardMainFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeBloc>().add(const HomeBoardScreenFabToggleRequested(isExpanded: true)),
      child: Container(
        width: 100.w,
        height: 46.h,
        decoration: BoxDecoration(
          color: AppColor.orange5,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/ic_글쓰기.svg",
              width: 16.w,
              height: 16.w,
            ),
            SizedBox(width: 4.w),
            Text(
              "글쓰기",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16.w, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
