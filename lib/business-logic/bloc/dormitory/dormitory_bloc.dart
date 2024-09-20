import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/data/repository/meal_repository.dart';

part 'dormitory_event.dart';
part 'dormitory_state.dart';

class DormitoryBloc extends Bloc<DormitoryEvent, DormitoryState> {
  final DormitoryMealRepository dormitoryMealRepository;

  DormitoryBloc({required this.dormitoryMealRepository}) : super(const DormitoryInitial()) {
    on<DormitoryMealLoadRequested>(onDormitoryMealLoadRequested);
  }

  Future<void> onDormitoryMealLoadRequested(DormitoryMealLoadRequested event, Emitter<DormitoryState> emit) async {
    List<MealData> mealDataList = await dormitoryMealRepository.fetchHappyMeals();

    emit(DormitoryMealLoaded(mealDataList: mealDataList));
  }
}
