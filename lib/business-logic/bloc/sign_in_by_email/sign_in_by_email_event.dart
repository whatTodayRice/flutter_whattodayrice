part of 'sign_in_by_email_bloc.dart';

sealed class SignInByEmailEvent extends Equatable {
  const SignInByEmailEvent();

  @override
  List<Object?> get props => [];
}

class SignInByEmailChanged extends SignInByEmailEvent {
  const SignInByEmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class SignInByEmailPasswordChanged extends SignInByEmailEvent {
  const SignInByEmailPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class SignInByEmailRequested extends SignInByEmailEvent {
  const SignInByEmailRequested();
}

final class SignInByEmailPasswordObscureChanged extends SignInByEmailEvent {
  const SignInByEmailPasswordObscureChanged({required this.isObscure});

  final bool isObscure;

  @override
  List<Object?> get props => [isObscure];
}
