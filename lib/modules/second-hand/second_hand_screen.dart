import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/create_post_submit_button.dart';
import 'package:go_router/go_router.dart';

class SecondHandScreen extends StatelessWidget {
  const SecondHandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('행복나눔거래', style: AppTextStyle.bold16.copyWith(color: AppColor.black000000)),
      ),
      body: Column(
        children: [
          CreatePostSubmitButton(
            isButtonEnabled: true,
            onTap: () => context.pushNamed(AppRouteState.createPost.name),
          ),
        ],
      ),
    );
  }
}
