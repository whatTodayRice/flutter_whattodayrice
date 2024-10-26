import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_menu_type.dart';

class MenuCardMenuRow extends StatelessWidget {
  const MenuCardMenuRow({
    super.key,
    required this.menu,
    required this.menuType,
  });

  final String menu;
  final MenuType menuType;

  @override
  Widget build(BuildContext context) {
    final TextStyle menuTextStyle = Theme.of(context).textTheme.bodySmall!.copyWith(overflow: TextOverflow.clip);
    final TextStyle menuTitleTextStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColor.gray8,
        );

    return SizedBox(
      width: 260,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(menuType.title, style: menuTitleTextStyle),
          SizedBox(width: 16.w),
          Expanded(child: Text(menu, style: menuTextStyle)),
        ],
      ),
    );
  }
}
