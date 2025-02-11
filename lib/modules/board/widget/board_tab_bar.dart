import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_post_type.dart';

class BoardTabBar extends StatelessWidget {
  const BoardTabBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelColor: AppColor.primary,
      indicatorColor: AppColor.primary,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColor.primary, width: 3.w),
      ),
      indicatorWeight: 3.0,
      unselectedLabelColor: Colors.white,
      tabAlignment: TabAlignment.start,
      controller: tabController,
      tabs: [
        Tab(
          child: Text(
            PostType.free.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16.w),
          ),
        ),
        Tab(
          child: Text(
            PostType.question.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16.w),
          ),
        ),
      ],
    );
  }
}
