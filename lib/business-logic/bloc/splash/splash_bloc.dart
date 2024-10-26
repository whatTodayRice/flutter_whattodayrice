import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository authRepository;

  SplashBloc({required this.authRepository}) : super(const SplashInitial()) {
    on<SplashSessionRequested>(_onSplashSessionRequested);
    on<SplashUserRequested>(_onSplashUserRequested);
  }

  Future<void> _onSplashSessionRequested(
    SplashSessionRequested event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    final response = await authRepository.getInitialSession();

    if (response.succeedData == null) {
      emit(SplashLoaded(routeName: AppRouteState.loginInfo.name));

      return;
    }

    add(const SplashUserRequested());
  }

  Future<void> _onSplashUserRequested(
    SplashUserRequested event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    final response = await authRepository.getUserProfile();

    if (response.succeedData == null) {
      emit(SplashLoaded(routeName: AppRouteState.loginInfo.name));

      return;
    }

    emit(SplashLoaded(routeName: AppRouteState.meal.name));
  }
}
