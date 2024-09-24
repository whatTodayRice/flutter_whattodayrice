part of 'dormitory_bloc.dart';

sealed class DormitoryState extends Equatable {
  const DormitoryState();

  @override
  List<Object?> get props => [];
}

class DormitoryInitial extends DormitoryState {
  const DormitoryInitial();
}

class DormitoryLoading extends DormitoryState {
  const DormitoryLoading();
}

class DormitoryError extends DormitoryState {
  const DormitoryError();
}

class DormitoryMealLoaded extends DormitoryState {
  const DormitoryMealLoaded({required this.mealDataList});

  final List<MealData> mealDataList;

  @override
  List<Object?> get props => [mealDataList];
}
