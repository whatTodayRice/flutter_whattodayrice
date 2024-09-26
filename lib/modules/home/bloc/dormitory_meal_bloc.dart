import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_meal_type.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/data/repository/meal_repository.dart';
import 'package:flutter_whattodayrice/modules/home/helper/dorm_meal_helper.dart';

part 'dormitory_meal_event.dart';
part 'dormitory_meal_state.dart';

class DormitoryMealBloc extends Bloc<DormitoryMealEvent, DormitoryMealState> {
  final DormitoryMealRepository dormitoryMealRepository;

  DormitoryMealBloc({required this.dormitoryMealRepository}) : super(const DormitoryMealInitial()) {
    on<DormitoryMealLoadRequested>(onDormitoryMealLoadRequested);
    on<DormitoryMealAvailableMealTypeRequested>(onDormitoryMealAvailableMealTypeRequested);
    on<DormitoryMealAvailableTimeUpdateRequested>(onDormitoryMealAvailableTimeUpdateRequested);
    on<DormitoryMealDateSelected>(onDormitoryMealDateSelected);

    scheduleMealTypeNotification();
  }

  List<MealData> mealDataList = [];
  late MealType availableMealType;
  late int selectedDayIndex;

  Future<void> onDormitoryMealLoadRequested(
    DormitoryMealLoadRequested event,
    Emitter<DormitoryMealState> emit,
  ) async {
    mealDataList = await dormitoryMealRepository.fetchHappyMeals();

    // 로그인한 요일의 index 반환(월-0, 일-6)
    selectedDayIndex = getCurrentDayIndex();

    // 초기화 시점 이용 가능한 식단 타입
    availableMealType = getCurrentAvailableMealType();

    emit(DormitoryMealLoaded(
      mealDataList: mealDataList,
      availableMealType: availableMealType,
      selectedDayIndex: selectedDayIndex,
    ));
  }

  Future<void> onDormitoryMealAvailableMealTypeRequested(
    DormitoryMealAvailableMealTypeRequested event,
    Emitter<DormitoryMealState> emit,
  ) async {
    availableMealType = event.availableMealType;

    emit(DormitoryMealLoaded(
      mealDataList: mealDataList,
      availableMealType: availableMealType,
      selectedDayIndex: selectedDayIndex,
    ));
  }

  Future<void> onDormitoryMealDateSelected(
    DormitoryMealDateSelected event,
    Emitter<DormitoryMealState> emit,
  ) async {
    selectedDayIndex = event.selectedDayIndex;

    emit(DormitoryMealLoaded(
      mealDataList: mealDataList,
      availableMealType: availableMealType,
      selectedDayIndex: selectedDayIndex,
    ));
  }

  Future<void> onDormitoryMealAvailableTimeUpdateRequested(
    DormitoryMealAvailableTimeUpdateRequested event,
    Emitter<DormitoryMealState> emit,
  ) async {
    availableMealType = getCurrentAvailableMealType();

    print("----availableMealType updated----");
    print(availableMealType);

    emit(DormitoryMealLoaded(
      mealDataList: mealDataList,
      availableMealType: availableMealType,
      selectedDayIndex: selectedDayIndex,
    ));
  }

  void scheduleMealTypeNotification() {
    // 한국 시간 기준
    final now = DateTime.now().toUtc().add(const Duration(hours: 9));

    final breakfastStart = DateTime(now.year, now.month, now.day, 7, 30);
    final breakfastEnd = DateTime(now.year, now.month, now.day, 9, 30);

    final lunchStart = DateTime(now.year, now.month, now.day, 11, 30);
    final lunchEnd = DateTime(now.year, now.month, now.day, 14, 00);

    final dinnerStart = DateTime(now.year, now.month, now.day, 16, 50);
    final dinnerEnd = DateTime(now.year, now.month, now.day, 19, 00);

    // 현재 시간에 맞는 타이머 설정
    if (now.isAfter(dinnerEnd) && now.isBefore(breakfastStart)) {
      setMealTimer(breakfastStart, MealType.breakfast);
    } else if (now.isAfter(breakfastEnd) && now.isBefore(lunchStart)) {
      setMealTimer(lunchStart, MealType.lunch);
    } else if (now.isAfter(lunchEnd) && now.isBefore(dinnerStart)) {
      setMealTimer(dinnerStart, MealType.dinner);
    }
  }

  void setMealTimer(DateTime mealTime, MealType mealType) {
    final now = DateTime.now().toUtc().add(const Duration(hours: 9));
    final duration = mealTime.difference(now);

    // 지정된 시간 후에 타이머로 MealType 이벤트 발생
    Future.delayed(duration, () {
      add(DormitoryMealAvailableMealTypeRequested(availableMealType: mealType));
    });
  }
}
