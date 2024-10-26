import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/register/register_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/app_elevated_button.dart';
import 'package:flutter_whattodayrice/presentation/view/components/kakao_button.dart';
import 'package:go_router/go_router.dart';

class LoginInfoScreen extends StatefulWidget {
  const LoginInfoScreen({super.key});

  @override
  State<LoginInfoScreen> createState() => _LoginInfoScreenState();
}

class _LoginInfoScreenState extends State<LoginInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterEmailSignUpSucceed) {
          context.goNamed(AppRouteState.home.name);

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
              KakaoButton(onTap: () async {
                context.read<RegisterBloc>().add(const RegisterKaKaoSignInRequested());
              }),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: AppElevatedButton(
                  title: "회원가입",
                  onPressed: () => context.pushNamed(AppRouteState.emailRegister.name),
                  textStyle: Theme.of(context).textTheme.titleSmall!,
                  buttonBorderColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  foregroundColor: AppColor.primary,
                  disabledBackgroundColor: AppColor.primary,
                  disabledForegroundColor: Colors.white,
                  borderRadiusValue: 12,
                  elevation: 0,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: AppElevatedButton(
                  title: "이메일로 로그인",
                  onPressed: () => context.pushNamed(AppRouteState.signIn.name),
                  textStyle: Theme.of(context).textTheme.titleSmall!,
                  buttonBorderColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColor.primary,
                  disabledForegroundColor: Colors.white,
                  borderRadiusValue: 12,
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
