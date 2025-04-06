import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this.authRepository, required this.userRepository}) : super(const SignInInitial()) {
    on<SignInKakaoTalkRequested>(_onSignInKakaoTalkRequested);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;

  Future<void> _onSignInKakaoTalkRequested(SignInKakaoTalkRequested event, Emitter<SignInState> emit) async {
    final response = await authRepository.signInWithKakaoTalk();

    if (!response.isSucceed) {
      return;
    }

    await userRepository.initUserProfile();

    emit(const SignInSucceed());
  }
}
