part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashLoaded extends SplashState {
  const SplashLoaded({required this.routeName});

  final String routeName;

  @override
  List<Object> get props => [routeName];
}
