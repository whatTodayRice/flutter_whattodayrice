import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SplashBloc({required this.authRepository, required this.userRepository}) : super(const SplashInitial()) {
    on<SplashSessionRequested>(_onSplashSessionRequested);
    on<SplashUserRequested>(_onSplashUserRequested);
  }

  Future<void> _onSplashSessionRequested(
    SplashSessionRequested event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    final accessToken = await authRepository.getAccessTokenFromCache();

    if (accessToken == null) {
      emit(SplashLoaded(routeName: AppRouteState.secondHand.name));

      return;
    }

    add(const SplashUserRequested());
  }

  Future<void> _onSplashUserRequested(
    SplashUserRequested event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    await userRepository.initUserProfile();

    emit(SplashLoaded(routeName: AppRouteState.secondHand.name));
  }
}
