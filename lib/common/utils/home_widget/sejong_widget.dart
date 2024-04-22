import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';

const String androidFullMealsWidgetName = 'FullMealsWidget';
const String androidMealWidgetName = 'MealWidget';

void updateFullMeal(MealData sejongMeal) {
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final tomorrow = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(const Duration(days: 1)));

  var hour = DateTime.now().hour;
  var minute = DateTime.now().minute;

  String targetDate = today;

  if (hour > 18 || (hour == 18 && minute >= 30)) {
    targetDate = tomorrow;
  }

  if (DateTime.now().weekday == DateTime.sunday) {
    HomeWidget.saveWidgetData("sejong_date", sejongMeal.date);
    HomeWidget.saveWidgetData<String>('sejong_breakfast',
        " 😭홈페이지에 식단이 업로드 되지 않았어요 \n\n 🍙조금만 기다려주시면 식단을 알려드릴게요");
    HomeWidget.saveWidgetData<String>('sejong_lunch', "");
    HomeWidget.saveWidgetData<String>('sejong_dinner', "");
  } else {
    if (sejongMeal.date == targetDate) {
      updateSejongFullWidgetDate(sejongMeal);
    }
  }

  HomeWidget.updateWidget(androidName: androidFullMealsWidgetName);
  HomeWidget.updateWidget(androidName: androidMealWidgetName);
}

void updateSejongFullWidgetDate(MealData sejongMeal) {
  HomeWidget.saveWidgetData("sejong_date", sejongMeal.date);
  HomeWidget.saveWidgetData<String>('sejong_breakfast', sejongMeal.breakfast);
  HomeWidget.saveWidgetData<String>('sejong_lunch', sejongMeal.lunch);
  HomeWidget.saveWidgetData<String>('sejong_dinner', sejongMeal.dinner);
}
