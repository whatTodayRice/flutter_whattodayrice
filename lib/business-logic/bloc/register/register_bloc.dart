import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

enum EmailDomain {
  gmail(title: "gmail.com"),
  naver(title: "naver.com"),
  custom(title: "직접 입력");

  final String title;

  const EmailDomain({required this.title});
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.authRepository}) : super(const RegisterInitial()) {
    on<RegisterKaKaoSignInRequested>(_onRegisterKaKaoSignInRequested);
    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterEmailDomainSelected>(_onRegisterEmailDomainSelected);
    on<RegisterEmailCustomDomainChanged>(_onRegisterEmailCustomDomainChanged);
    on<RegisterFirstPasswordChanged>(_onRegisterFirstPasswordChanged);
    on<RegisterSecondPasswordChanged>(_onRegisterSecondPasswordChanged);
  }

  final AuthRepository authRepository;

  String email = "";
  String emailDomain = EmailDomain.gmail.title;
  bool isEmailValidated = false;

  String firstPassword = "";
  bool isFirstPasswordValidated = false;

  String secondPassword = "";

  Future<void> _onRegisterKaKaoSignInRequested(RegisterKaKaoSignInRequested event, Emitter<RegisterState> emit) async {
    final response = await authRepository.signInWithKakao();

    if (!response.isSucceed) {
      return;
    }

    emit(const RegisterEmailSignUpSucceed());
  }

  Future<void> _onRegisterEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) async {
    email = event.email;
  }

  Future<void> _onRegisterEmailDomainSelected(
    RegisterEmailDomainSelected event,
    Emitter<RegisterState> emit,
  ) async {
    emailDomain = event.emailDomain.title;

    emit(RegisterEmailCustomDomainSelectedChecked(
      isCustomEmailDomainSelected: event.isCustomDomainSelected,
      emailDomain: event.emailDomain,
    ));
  }

  Future<void> _onRegisterEmailCustomDomainChanged(
    RegisterEmailCustomDomainChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emailDomain = event.customEmailDomain;

    if (!isValidEmailDomain(event.customEmailDomain)) {
      emit(const RegisterEmailValidationChecked(isEmailValidated: false));

      return;
    }

    isEmailValidated = email.isNotEmpty;

    emit(RegisterEmailValidationChecked(isEmailValidated: isEmailValidated));
  }

  Future<void> _onRegisterFirstPasswordChanged(RegisterFirstPasswordChanged event, Emitter<RegisterState> emit) async {
    firstPassword = event.password;

    isFirstPasswordValidated = firstPassword.isNotEmpty && !(firstPassword.length < 10 || firstPassword.length > 20);

    if (!isFirstPasswordValidated) {
      emit(RegisterEmailValidationChecked(isEmailValidated: isEmailValidated, isFirstPasswordValidated: false));

      return;
    }

    emit(RegisterEmailValidationChecked(isEmailValidated: isEmailValidated, isFirstPasswordValidated: true));
  }

  Future<void> _onRegisterSecondPasswordChanged(
      RegisterSecondPasswordChanged event, Emitter<RegisterState> emit) async {
    secondPassword = event.password;

    if (firstPassword != secondPassword) {
      emit(RegisterEmailValidationChecked(
        isEmailValidated: isEmailValidated,
        isFirstPasswordValidated: isFirstPasswordValidated,
        isSecondPasswordValidated: false,
      ));

      return;
    }

    if (firstPassword == secondPassword) {
      emit(RegisterEmailValidationChecked(
        isEmailValidated: isEmailValidated,
        isFirstPasswordValidated: isFirstPasswordValidated,
        isSecondPasswordValidated: true,
      ));
    }
  }
}

bool isValidEmailDomain(String domain) {
  final RegExp domainRegExp = RegExp(
    r'^[a-zA-Z0-9-]+\.[a-zA-Z]{3,}$',
  );
  return domainRegExp.hasMatch(domain);
}
