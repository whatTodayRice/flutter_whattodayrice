import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SettingBloc({required this.authRepository, required this.userRepository}) : super(const SettingInitial()) {
    on<SettingLogOutRequested>(_onSettingLogOutRequested);
  }

  Future<void> _onSettingLogOutRequested(
    SettingLogOutRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoading());

    userRepository.clearUserProfile();

    final response = await authRepository.signOut();

    if (!response.isSucceed) {
      return;
    }

    emit(const SettingLoaded(isLogOut: true));
  }
}
