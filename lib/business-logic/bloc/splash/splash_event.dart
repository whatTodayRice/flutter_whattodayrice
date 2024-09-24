part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

final class SplashSessionRequested extends SplashEvent {
  const SplashSessionRequested();
}

final class SplashUserRequested extends SplashEvent {
  const SplashUserRequested();
}

final class SplashDataRequested extends SplashEvent {
  const SplashDataRequested();
}
