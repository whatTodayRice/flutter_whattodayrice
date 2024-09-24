part of 'sign_in_by_email_bloc.dart';

sealed class SignInByEmailState extends Equatable {
  const SignInByEmailState();

  @override
  List<Object?> get props => [];
}

class SignInByEmailInitial extends SignInByEmailState {
  const SignInByEmailInitial();
}

class SignInByEmailLoading extends SignInByEmailState {
  const SignInByEmailLoading();
}

class SignInByEmailError extends SignInByEmailState {
  const SignInByEmailError({required this.errorMsg});

  final String errorMsg;

  @override
  List<Object?> get props => [errorMsg];
}

class SignInByEmailSucceed extends SignInByEmailState {
  const SignInByEmailSucceed();
}

class SignInByEmailValidationChecked extends SignInByEmailState {
  const SignInByEmailValidationChecked({required this.isButtonEnabled});

  final bool isButtonEnabled;

  @override
  List<Object?> get props => [isButtonEnabled];
}

class SignInByEmailPasswordObscureChecked extends SignInByEmailState {
  const SignInByEmailPasswordObscureChecked({required this.isObscured});

  final bool isObscured;

  @override
  List<Object?> get props => [isObscured];
}
