part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterError extends RegisterState {
  const RegisterError({this.errorMessage});

  final String? errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

final class RegisterEmailSignUpSucceed extends RegisterState {
  const RegisterEmailSignUpSucceed();
}

final class RegisterEmailCustomDomainSelectedChecked extends RegisterState {
  const RegisterEmailCustomDomainSelectedChecked({
    required this.isCustomEmailDomainSelected,
    required this.emailDomain,
  });

  final bool isCustomEmailDomainSelected;
  final EmailDomain emailDomain;

  @override
  List<Object?> get props => [isCustomEmailDomainSelected, emailDomain];
}

final class RegisterEmailValidationChecked extends RegisterState {
  const RegisterEmailValidationChecked({
    this.isEmailValidated,
    this.isFirstPasswordValidated,
    this.isSecondPasswordValidated,
  });

  final bool? isEmailValidated;
  final bool? isFirstPasswordValidated;
  final bool? isSecondPasswordValidated;

  @override
  List<Object?> get props => [isEmailValidated, isFirstPasswordValidated, isSecondPasswordValidated];
}
