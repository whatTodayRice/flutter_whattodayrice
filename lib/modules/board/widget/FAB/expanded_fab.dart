import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_post_type.dart';
import 'package:flutter_whattodayrice/modules/board/widget/FAB/expanded_button.dart';
import 'package:flutter_whattodayrice/modules/board/widget/FAB/fab_close.dart';
import 'package:flutter_whattodayrice/modules/board/widget/FAB/fab_item.dart';
import 'package:flutter_whattodayrice/modules/home/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';

class ExpandedFab extends StatelessWidget {
  const ExpandedFab({super.key, required this.fabItems});

  final List<FABItem> fabItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, bottom: 26.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(const HomeBoardScreenFabToggleRequested(isExpanded: false));
              context.pushNamed(AppRouteState.postCreation.name, extra: PostType.free);
            },
            child: ExpandedButton(item: fabItems[0]),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(const HomeBoardScreenFabToggleRequested(isExpanded: false));
              context.pushNamed(AppRouteState.postCreation.name, extra: PostType.question);
            },
            child: ExpandedButton(item: fabItems[1]),
          ),
          SizedBox(height: 17.h),
          GestureDetector(
              onTap: () => context.read<HomeBloc>().add(const HomeBoardScreenFabToggleRequested(isExpanded: false)),
              child: const FabCloseButton()),
        ],
      ),
    );
  }
}
