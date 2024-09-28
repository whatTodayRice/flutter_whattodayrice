class MealData {
  final String date;
  final String breakfast;
  final String? takeout;
  final String lunchNormal;
  final String? lunchPremium;
  final String dinnerNormal;
  final String? dinnerPremium;

  MealData({
    required this.date,
    required this.breakfast,
    this.takeout,
    required this.lunchNormal,
    this.lunchPremium,
    required this.dinnerNormal,
    this.dinnerPremium,
  });
}
