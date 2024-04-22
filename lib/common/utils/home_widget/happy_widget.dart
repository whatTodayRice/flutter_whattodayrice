import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';

void updateMeal(MealData happyMeal) {
  const String androidFullMealsWidgetName = 'FullMealsWidget';
  const String androidMealWidgetName = 'MealWidget';

  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final tomorrow = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(const Duration(days: 1)));

  var hour = DateTime.now().hour;
  String targetDate = today;

  if (hour >= 19) {
    targetDate = tomorrow;
  }

  if (happyMeal.date == targetDate) {
    saveHappyWidgetData(happyMeal);
  }
  HomeWidget.updateWidget(androidName: androidFullMealsWidgetName);
  HomeWidget.updateWidget(androidName: androidMealWidgetName);
}

void saveHappyWidgetData(MealData happyMeal) {
  HomeWidget.saveWidgetData("happy_date", happyMeal.date);
  HomeWidget.saveWidgetData<String>('happy_breakfast', happyMeal.breakfast);
  HomeWidget.saveWidgetData<String>('happy_takeout', happyMeal.takeout);
  HomeWidget.saveWidgetData<String>('happy_lunch', happyMeal.lunch);
  HomeWidget.saveWidgetData<String>('happy_dinner', happyMeal.dinner);
}
