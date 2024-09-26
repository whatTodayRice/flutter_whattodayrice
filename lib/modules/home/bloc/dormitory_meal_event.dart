part of 'dormitory_meal_bloc.dart';

sealed class DormitoryMealEvent extends Equatable {
  const DormitoryMealEvent();

  @override
  List<Object?> get props => [];
}

class DormitoryMealLoadRequested extends DormitoryMealEvent {
  const DormitoryMealLoadRequested();
}

class DormitoryMealAvailableMealTypeRequested extends DormitoryMealEvent {
  const DormitoryMealAvailableMealTypeRequested({required this.availableMealType});

  final MealType availableMealType;

  @override
  List<Object?> get props => [availableMealType];
}

class DormitoryMealDateSelected extends DormitoryMealEvent {
  const DormitoryMealDateSelected({required this.selectedDayIndex});

  final int selectedDayIndex;

  @override
  List<Object?> get props => [selectedDayIndex];
}

class DormitoryMealAvailableTimeUpdateRequested extends DormitoryMealEvent {
  const DormitoryMealAvailableTimeUpdateRequested();
}
