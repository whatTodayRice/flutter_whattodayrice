package com.example.flutter_whattodayrice

import android.annotation.TargetApi
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.icu.text.SimpleDateFormat
import android.os.Build
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import java.util.Calendar

/**
 * Implementation of App Widget functionality.
 */
class MealWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.meal_widget).apply {
                val sejongDate = widgetData.getString("sejong_date", null)
                setTextViewText(R.id.date, sejongDate ?: "no date set")

                //todo 시간에 따른 로직 추가

                val calendar = Calendar.getInstance()
                val hour = calendar.get(Calendar.HOUR_OF_DAY)
                val minute = calendar.get(Calendar.MINUTE)

                //todo : 저장된 기숙사값을 defValue로 적용해주기
                val is_sejong = widgetData.getBoolean("is_sejong", true )
                if(is_sejong) {
                    if (hour < 7 || hour == 7 && minute <= 30) {
                        Log.d("breakfast", "true")
                        val sejongBreakfast = widgetData.getString("sejong_breakfast", null)
                        setTextViewText(R.id.meal, sejongBreakfast ?: "No title set")
                    }
                    if (hour >= 9) {
                        Log.d("lunch", "true")

                        val sejongLunch = widgetData.getString("sejong_lunch", null)
                        setTextViewText(R.id.meal, sejongLunch ?: "No title set")
                    }

                    if (hour > 13 || hour == 13 && minute >= 30) {
                        Log.d("dinner", "true")
                        val sejongDinner = widgetData.getString("sejong_dinner", null)
                        setTextViewText(R.id.meal, sejongDinner ?: "No title set")
                    }
                    //18:30 이후이면 다음 날 아침을

                    if (hour > 18 || hour == 18 && minute >= 30) {
                        Log.d("next", "true")
                        val sejongNextBreakfast = widgetData.getString("sejong_breakfast", null)
                        setTextViewText(R.id.meal, sejongNextBreakfast ?: "No title set")

                    }
                }
                else {
                    val date = widgetData.getString("happy_date", null)
                    setTextViewText(R.id.date, date ?: "no date set")

                    val breakfast = widgetData.getString("happy_breakfast", null)
                    setTextViewText(R.id.meal, breakfast ?: "No title set")
                }




            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }


}
