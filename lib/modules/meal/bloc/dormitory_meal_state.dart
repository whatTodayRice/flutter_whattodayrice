part of 'dormitory_meal_bloc.dart';

sealed class DormitoryMealState extends Equatable {
  const DormitoryMealState();

  @override
  List<Object?> get props => [];
}

class DormitoryMealInitial extends DormitoryMealState {
  const DormitoryMealInitial();
}

class DormitoryMealLoading extends DormitoryMealState {
  const DormitoryMealLoading();
}

class DormitoryMealError extends DormitoryMealState {
  const DormitoryMealError();
}

class DormitoryMealLoaded extends DormitoryMealState {
  const DormitoryMealLoaded({
    required this.mealDataList,
    required this.availableMealType,
    required this.selectedDayIndex,
  });

  final List<MealData> mealDataList;
  final MealType availableMealType;
  final int selectedDayIndex;

  @override
  List<Object?> get props => [mealDataList, availableMealType, selectedDayIndex];
}
