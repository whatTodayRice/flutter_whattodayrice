class MealData {
  final String date;
  final String breakfast;
  final String? takeout;
  final String lunch;
  final String dinner;

  MealData({
    required this.date,
    required this.breakfast,
    this.takeout,
    required this.lunch,
    required this.dinner,
  });
}

enum MealType { breakfast, lunch, dinner }
