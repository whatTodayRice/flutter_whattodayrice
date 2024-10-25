part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeError extends HomeState {
  const HomeError();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.selectedIndex,
    this.isBoardFABExpanded = false,
  });

  final int selectedIndex;
  final bool? isBoardFABExpanded;

  @override
  List<Object?> get props => [selectedIndex, isBoardFABExpanded];
}
