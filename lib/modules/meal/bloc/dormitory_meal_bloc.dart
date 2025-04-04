import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_meal_type.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/data/repository/meal_repository.dart';
import 'package:flutter_whattodayrice/modules/meal/helper/dorm_meal_helper.dart';

part 'dormitory_meal_event.dart';
part 'dormitory_meal_state.dart';

class DormitoryMealBloc extends Bloc<DormitoryMealEvent, DormitoryMealState> {
  final DormitoryMealRepository dormitoryMealRepository;

  DormitoryMealBloc({required this.dormitoryMealRepository}) : super(const DormitoryMealInitial()) {
    on<DormitoryMealLoadRequested>(_onDormitoryMealLoadRequested);
    on<DormitoryMealDateSelected>(_onDormitoryMealDateSelected);
  }

  List<MealData> mealDataList = [];
  late MealType availableMealType;
  late int selectedDayIndex;

  Future<void> _onDormitoryMealLoadRequested(
    DormitoryMealLoadRequested event,
    Emitter<DormitoryMealState> emit,
  ) async {
    mealDataList = await dormitoryMealRepository.fetchHappyMeals();

    // 로그인한 요일의 index 반환(월-0, 일-6)
    selectedDayIndex = DormMealHelper.getCurrentDayIndex();

    // 초기화 시점 이용 가능한 식단 타입
    availableMealType = DormMealHelper.getCurrentAvailableMealType();

    emit(DormitoryMealLoaded(
      mealDataList: mealDataList,
      availableMealType: availableMealType,
      selectedDayIndex: selectedDayIndex,
    ));
  }

  Future<void> _onDormitoryMealDateSelected(
    DormitoryMealDateSelected event,
    Emitter<DormitoryMealState> emit,
  ) async {
    selectedDayIndex = event.selectedDayIndex;

    availableMealType = DormMealHelper.getCurrentAvailableMealType();

    emit(DormitoryMealLoaded(
      mealDataList: mealDataList,
      availableMealType: availableMealType,
      selectedDayIndex: selectedDayIndex,
    ));
  }
}
