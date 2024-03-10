class MealData {
  final String date;
  final String? breakfast;
  final String? takeout;
  final String? lunch;
  final String? dinner;

  MealData({
    required this.date,
    this.breakfast,
    this.takeout,
    this.lunch,
    this.dinner,
  });
}

enum MealType { breakfast, lunch, dinner }
