import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

class KakaoButton extends StatelessWidget {
  const KakaoButton({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.yellow),
        child: Row(
          children: [
            Image.asset("assets/images/ic_kakao.png", color: Colors.black),
            const Spacer(),
            Text(
              "카카오 로그인",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black.withOpacity(0.85)),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
