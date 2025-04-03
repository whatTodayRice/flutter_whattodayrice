import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/modules/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/modules/sign_in/widget/kakao_button.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSucceed) {
          context.goNamed(AppRouteState.meal.name);

          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/splash/splash.png",
                width: 130,
                height: 130,
                color: Colors.white,
              ),
              Text(
                "오늘 밥 뭐야?",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white, fontSize: 28),
              ),
              const SizedBox(height: 12),
              Text(
                "식단 확인부터 중고거래까지!\n기숙사 생활을 편리하게",
                style:
                    Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 28),
              KakaoButton(
                onTap: () => context.read<SignInBloc>().add(const SignInKakaoTalkRequested()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
