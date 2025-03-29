import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/post_creation_button.dart';

class SecondHandScreen extends StatelessWidget {
  const SecondHandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '게시글 작성',
          style: AppTextStyle.bold16.copyWith(color: AppColor.black000000),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {},
          child: Text(
            '취소',
            style: AppTextStyle.regular16.copyWith(color: AppColor.grayA0A0A0),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ),
          SubmitButton(isButtonEnabled: true),
        ],
      ),
    );
  }
}
