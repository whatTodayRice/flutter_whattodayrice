part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeBottomNavigationBarSelected extends HomeEvent {
  const HomeBottomNavigationBarSelected({required this.selectedIndex});

  final int selectedIndex;

  @override
  List<Object?> get props => [selectedIndex];
}

final class HomeBoardScreenFabToggleRequested extends HomeEvent {
  const HomeBoardScreenFabToggleRequested({required this.isExpanded});

  final bool isExpanded;

  @override
  List<Object?> get props => [isExpanded];
}
