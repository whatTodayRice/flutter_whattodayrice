import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/register/register_bloc.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/app_elevated_button.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/app_text_field.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/w_custom_close_button.dart';

class RegisterEmailScreen extends StatefulWidget {
  const RegisterEmailScreen({super.key});

  @override
  State<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  late final RegisterBloc _registerBloc;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordCheckFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _registerBloc = context.read<RegisterBloc>();

    _passwordController.addListener(
          () => _registerBloc.add(
        RegisterFirstPasswordChanged(password: _passwordController.text),
      ),
    );
    _passwordCheckController.addListener(
          () => _registerBloc.add(
        RegisterSecondPasswordChanged(password: _passwordCheckController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    bool isFirstPasswordValidationChecked = false;
                    bool isSecondPasswordValidated = false;

                    if (state is RegisterEmailValidationChecked && state.isFirstPasswordValidated == true) {
                      isFirstPasswordValidationChecked = true;
                    }

                    if (state is RegisterEmailValidationChecked && state.isSecondPasswordValidated == true) {
                      isSecondPasswordValidated = true;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 56),
                        Text(
                          "이메일과 비밀번호를\n입력해 주세요.",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 26),
                        ),
                        const SizedBox(height: 24),
                        const EmailInputField(),
                        AppTextField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18),
                          hintText: '비밀번호 (10~20자리 이내)',
                          hintTextStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18, color: AppColor.gray),
                          suffixIcon: isFirstPasswordValidationChecked
                              ? const CustomTextFieldSuffixIcon(icon: Icon(Icons.check, color: AppColor.primary))
                              : null,
                          borderColor: Colors.transparent,
                          isRequiredEnabledBorder: true,
                          isRequiredFocusedBorder: true,
                        ),
                        AppTextField(
                          controller: _passwordCheckController,
                          focusNode: _passwordCheckFocusNode,
                          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18),
                          hintText: '비밀번호 확인',
                          hintTextStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18, color: AppColor.gray),
                          suffixIcon: isSecondPasswordValidated
                              ? const CustomTextFieldSuffixIcon(icon: Icon(Icons.check, color: AppColor.primary))
                              : null,
                          borderColor: Colors.transparent,
                          isRequiredEnabledBorder: true,
                          isRequiredFocusedBorder: true,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: AppElevatedButton(
                    title: "가입 하기",
                    onPressed: () {},
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 15.sp),
                    buttonBorderColor: AppColor.primary,
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    borderRadiusValue: 12,
                    elevation: 0,
                    disabledForegroundColor: AppColor.primary,
                    disabledBackgroundColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInputField extends StatefulWidget {
  const EmailInputField({super.key});

  @override
  State<EmailInputField> createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  late final RegisterBloc _registerBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customDomainController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _customDomainFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _registerBloc = context.read<RegisterBloc>();

    _emailController.addListener(
          () => _registerBloc.add(RegisterEmailChanged(email: _emailController.text)),
    );

    _customDomainController.addListener(
          () => _registerBloc.add(RegisterEmailCustomDomainChanged(customEmailDomain: _customDomainController.text)),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _customDomainController.dispose();
    _emailFocusNode.dispose();
    _customDomainFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18),
            hintText: '이메일',
            hintTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18, color: AppColor.gray),
            borderColor: Colors.transparent,
            isRequiredEnabledBorder: true,
            isRequiredFocusedBorder: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('@', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18)),
        ),
        BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (_, current) => current is RegisterEmailCustomDomainSelectedChecked,
          builder: (context, state) {
            EmailDomain selectedDomain = EmailDomain.gmail;
            bool isCustomDomainSelected = false;

            if (state is RegisterEmailCustomDomainSelectedChecked && state.isCustomEmailDomainSelected) {
              isCustomDomainSelected = true;
            }

            if (state is RegisterEmailCustomDomainSelectedChecked && !state.isCustomEmailDomainSelected) {
              selectedDomain = state.emailDomain;
            }

            return isCustomDomainSelected
                ? BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                bool isEmailValidated = false;

                if (state is RegisterEmailValidationChecked && state.isEmailValidated == true) {
                  isEmailValidated = true;
                }

                return Expanded(
                  child: AppTextField(
                    controller: _customDomainController,
                    focusNode: _customDomainFocusNode,
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20),
                    hintText: '직접 입력',
                    hintTextStyle:
                    Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20, color: AppColor.gray),
                    borderColor: Colors.transparent,
                    suffixIcon: isEmailValidated
                        ? const CustomTextFieldSuffixIcon(icon: Icon(Icons.check, color: AppColor.primary))
                        : null,
                    isRequiredEnabledBorder: true,
                    isRequiredFocusedBorder: true,
                  ),
                );
              },
            )
                : DropdownButton<EmailDomain>(
              value: selectedDomain,
              items: EmailDomain.values.map(
                    (EmailDomain value) {
                  return DropdownMenuItem<EmailDomain>(
                    value: value,
                    child: Text(
                      value.title,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18),
                    ),
                  );
                },
              ).toList(),
              onChanged: (EmailDomain? emailDomain) {
                if (emailDomain == null) {
                  return;
                }

                if (emailDomain == EmailDomain.custom) {
                  context.read<RegisterBloc>().add(
                    RegisterEmailDomainSelected(
                      isCustomDomainSelected: true,
                      emailDomain: emailDomain,
                    ),
                  );
                } else {
                  context.read<RegisterBloc>().add(
                    RegisterEmailDomainSelected(
                      isCustomDomainSelected: false,
                      emailDomain: emailDomain,
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
