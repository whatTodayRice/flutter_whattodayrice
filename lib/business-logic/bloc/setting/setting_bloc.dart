import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AuthRepository authRepository;

  SettingBloc({required this.authRepository}) : super(const SettingInitial()) {
    on<SettingLogOutRequested>(_onSettingLogOutRequested);
  }

  Future<void> _onSettingLogOutRequested(
    SettingLogOutRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoading());

    final response = await authRepository.signOut();

    if (!response.isSucceed) {
      return;
    }

    emit(const SettingLoaded(isLogOut: true));
  }
}
