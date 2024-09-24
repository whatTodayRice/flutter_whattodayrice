import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';

part 'sign_in_by_email_event.dart';
part 'sign_in_by_email_state.dart';

class SignInByEmailBloc extends Bloc<SignInByEmailEvent, SignInByEmailState> {
  final AuthRepository authRepository;

  SignInByEmailBloc({required this.authRepository}) : super(const SignInByEmailInitial()) {
    on<SignInByEmailChanged>(_onSignInByEmailChanged);
    on<SignInByEmailPasswordChanged>(_onSignInByPasswordChanged);
    on<SignInByEmailRequested>(_onSignInByEmailRequested);
    on<SignInByEmailPasswordObscureChanged>(_onSignInByEmailPasswordObscureChanged);
  }

  String email = "";
  String password = "";

  Future<void> _onSignInByEmailChanged(SignInByEmailChanged event, Emitter<SignInByEmailState> emit) async {
    email = event.email;

    emit(SignInByEmailValidationChecked(isButtonEnabled: email.isNotEmpty && password.isNotEmpty));
  }

  Future<void> _onSignInByPasswordChanged(SignInByEmailPasswordChanged event, Emitter<SignInByEmailState> emit) async {
    password = event.password;

    emit(SignInByEmailValidationChecked(isButtonEnabled: email.isNotEmpty && password.isNotEmpty));
  }

  Future<void> _onSignInByEmailRequested(SignInByEmailRequested event, Emitter<SignInByEmailState> emit) async {
    final response = await authRepository.signInByEmail(email: email, password: password);

    if (!response.isSucceed) {
      emit(const SignInByEmailError(errorMsg: "이메일 가입 사용자가 아니거나 잘못된 비밀번호에요."));

      return;
    }

    emit(const SignInByEmailSucceed());
  }

  Future<void> _onSignInByEmailPasswordObscureChanged(
      SignInByEmailPasswordObscureChanged event, Emitter<SignInByEmailState> emit) async {
    emit(SignInByEmailPasswordObscureChecked(isObscured: event.isObscure));
  }
}
