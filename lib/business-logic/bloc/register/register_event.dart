part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

final class RegisterKaKaoSignInRequested extends RegisterEvent {
  const RegisterKaKaoSignInRequested();
}

final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

final class RegisterEmailDomainSelected extends RegisterEvent {
  const RegisterEmailDomainSelected({required this.emailDomain, required this.isCustomDomainSelected});

  final EmailDomain emailDomain;
  final bool isCustomDomainSelected;

  @override
  List<Object?> get props => [emailDomain, isCustomDomainSelected];
}

final class RegisterEmailCustomDomainChanged extends RegisterEvent {
  const RegisterEmailCustomDomainChanged({required this.customEmailDomain});

  final String customEmailDomain;

  @override
  List<Object?> get props => [customEmailDomain];
}

final class RegisterFirstPasswordChanged extends RegisterEvent {
  const RegisterFirstPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

final class RegisterSecondPasswordChanged extends RegisterEvent {
  const RegisterSecondPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

final class RegisterEmailSignUpRequested extends RegisterEvent {
  const RegisterEmailSignUpRequested();
}
