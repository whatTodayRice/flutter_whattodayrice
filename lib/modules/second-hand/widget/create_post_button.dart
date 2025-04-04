import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/utils/login_validator.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:go_router/go_router.dart';

class CreatePostButton extends StatelessWidget {
  const CreatePostButton({
    super.key,
    this.onRefresh,
  });

  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final isLoggedIn = LoginValidator.isUserLoggedIn();

        if (isLoggedIn != true) {
          final result = await LoginValidator.validate(context);

          if (result != true) {
            return;
          }
        }

        final result = await context.pushNamed(AppRouteState.createPost.name);

        if (result != true) {
          return;
        }

        onRefresh?.call();
      },
      child: Container(
        width: 100,
        height: 46,
        decoration: BoxDecoration(color: AppColor.orangeFF823B, borderRadius: BorderRadius.circular(23)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.iconCreatePostFab.svg(),
            const SizedBox(width: 6),
            Text(
              '글쓰기',
              style: AppTextStyle.regular16.copyWith(color: AppColor.whiteF8F8F8),
            ),
          ],
        ),
      ),
    );
  }
}
