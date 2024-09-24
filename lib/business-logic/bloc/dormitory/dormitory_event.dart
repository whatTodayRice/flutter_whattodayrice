part of 'dormitory_bloc.dart';

sealed class DormitoryEvent extends Equatable {
  const DormitoryEvent();

  @override
  List<Object?> get props => [];
}

class DormitoryMealLoadRequested extends DormitoryEvent {
  const DormitoryMealLoadRequested();
}