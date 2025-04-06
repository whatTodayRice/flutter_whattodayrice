import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

class AppBarNormal extends StatelessWidget implements PreferredSizeWidget {
  const AppBarNormal({super.key, this.onTap, this.centerTitle, this.title});

  final VoidCallback? onTap;
  final bool? centerTitle;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: onTap ?? () => Navigator.of(context).pop(),
        child: Assets.images.svg.iconLeftArrowGray.svg(fit: BoxFit.scaleDown),
      ),
      centerTitle: centerTitle,
      title: title != null ? Text(title!, style: AppTextStyle.bold16.copyWith(color: AppColor.black000000)) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
