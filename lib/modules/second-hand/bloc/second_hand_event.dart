part of 'second_hand_bloc.dart';

sealed class SecondHandEvent extends Equatable {
  const SecondHandEvent();

  @override
  List<Object?> get props => [];
}

final class SecondHandLoadRequested extends SecondHandEvent {
  const SecondHandLoadRequested();
}

final class SecondHandRefreshRequested extends SecondHandEvent {
  const SecondHandRefreshRequested();
}
