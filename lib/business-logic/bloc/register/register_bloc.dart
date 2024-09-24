import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.authRepository}) : super(const RegisterInitial()) {
    on<RegisterKaKaoSignInRequested>(_onRegisterKaKaoSignInRequested);
  }

  final AuthRepository authRepository;

  Future<void> _onRegisterKaKaoSignInRequested(RegisterKaKaoSignInRequested event, Emitter<RegisterState> emit) async {
    final response = await authRepository.signInWithKakao();

    if (!response.isSucceed) {
      return;
    }

    emit(const RegisterSucceed());
  }
}
