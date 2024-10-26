import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/sign_in_by_email/sign_in_by_email_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/app_elevated_button.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/app_text_field.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/w_custom_close_button.dart';
import 'package:go_router/go_router.dart';

class SignInByEmailScreen extends StatefulWidget {
  const SignInByEmailScreen({super.key});

  @override
  State<SignInByEmailScreen> createState() => _SignInByEmailScreenState();
}

class _SignInByEmailScreenState extends State<SignInByEmailScreen> {
  late final SignInByEmailBloc _signInByEmailBloc;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _signInByEmailBloc = context.read<SignInByEmailBloc>();

    _emailController = TextEditingController()
      ..addListener(() {
        _signInByEmailBloc.add(SignInByEmailChanged(email: _emailController.text));
      });

    _passwordController = TextEditingController()
      ..addListener(() {
        _signInByEmailBloc.add(SignInByEmailPasswordChanged(password: _passwordController.text));
      });
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _emailController.removeListener(
      () => _signInByEmailBloc.add(
        SignInByEmailChanged(email: _emailController.text),
      ),
    );

    _passwordController.removeListener(
      () => _signInByEmailBloc.add(
        SignInByEmailPasswordChanged(password: _passwordController.text),
      ),
    );

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInByEmailBloc, SignInByEmailState>(
      listener: (context, state) {
        if (state is SignInByEmailSucceed) {
          context.go("/${AppRouteState.home.name}");
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "식단 확인부터 중고거래까지!\n기숙사 생활을 더욱 편리하게 이용해보세요.",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 28),
              AppTextField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                hintText: "이메일",
                suffixIcon: CustomTextFieldSuffixIcon(
                  icon: const Icon(Icons.cancel, size: 24, color: AppColor.gray2),
                  onPressed: () {
                    _emailController.clear();
                    _emailFocusNode.requestFocus();
                  },
                ),
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                hintTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              BlocBuilder<SignInByEmailBloc, SignInByEmailState>(
                buildWhen: (_, current) => current is SignInByEmailPasswordObscureChecked,
                builder: (context, state) {
                  bool isObscured = true;

                  if (state is SignInByEmailPasswordObscureChecked) {
                    isObscured = state.isObscured;
                  }

                  return AppTextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                    hintTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                    isObscure: isObscured,
                    hintText: "비밀번호",
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _signInByEmailBloc.add(SignInByEmailPasswordObscureChanged(isObscure: !isObscured)),
                      icon: isObscured ? const Icon(CupertinoIcons.eye_slash) : const Icon(CupertinoIcons.eye),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<SignInByEmailBloc, SignInByEmailState>(
                buildWhen: (_, current) => current is SignInByEmailValidationChecked,
                builder: (context, state) {
                  bool isButtonEnabled = false;

                  if (state is SignInByEmailValidationChecked) {
                    isButtonEnabled = state.isButtonEnabled;
                  }

                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: AppElevatedButton(
                      title: "로그인",
                      textStyle: Theme.of(context).textTheme.titleSmall!,
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.white,
                      disabledForegroundColor: Colors.grey,
                      onPressed: isButtonEnabled ? () => _signInByEmailBloc.add(const SignInByEmailRequested()) : null,
                      buttonBorderColor: Colors.transparent,
                      borderRadiusValue: 8,
                      elevation: 0,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              BlocBuilder<SignInByEmailBloc, SignInByEmailState>(
                buildWhen: (_, current) => current is SignInByEmailError,
                builder: (context, state) {
                  String errorMsg = "";

                  if (state is SignInByEmailError) {
                    errorMsg = state.errorMsg;
                  }

                  return Text(
                    errorMsg,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.red),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
