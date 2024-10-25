import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeBoardScreenFabToggleRequested>(_onHomeBoardScreenFabToggleRequested);
    on<HomeBottomNavigationBarSelected>(_onHomeBottomNavigationBarSelected);
  }

  bool isBoardScreenFabExpanded = false;
  int selectedIndex = 0;

  Future<void> _onHomeBoardScreenFabToggleRequested(
    HomeBoardScreenFabToggleRequested event,
    Emitter<HomeState> emit,
  ) async {
    isBoardScreenFabExpanded = event.isExpanded;

    emit(HomeLoaded(
      selectedIndex: selectedIndex,
      isBoardFABExpanded: isBoardScreenFabExpanded,
    ));
  }

  Future<void> _onHomeBottomNavigationBarSelected(
    HomeBottomNavigationBarSelected event,
    Emitter<HomeState> emit,
  ) async {
    selectedIndex = event.selectedIndex;

    emit(HomeLoaded(
      selectedIndex: selectedIndex,
      isBoardFABExpanded: isBoardScreenFabExpanded,
    ));
  }
}
