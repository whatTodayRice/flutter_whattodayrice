package com.whatTodayRice

import android.annotation.TargetApi
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.os.Build
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import java.util.Calendar

/**
 * Implementation of App Widget functionality.
 */
class FullMealsWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray

    ) {
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.full_meals_widget).apply {


                val calendar = Calendar.getInstance()
                val hour = calendar.get(Calendar.HOUR_OF_DAY)
                val minute = calendar.get(Calendar.MINUTE)

                var is_sejong = widgetData.getBoolean("is_sejong", false )
                //todo: 추후 앱 초기 진입 시 받은 기숙사 값을 저장하여 해당 기숙사값과 연동하기
                if (is_sejong) {
                    var sejongDate = widgetData.getString("sejong_date", null)
                    if(hour>18 || hour==18 && minute>=30) {
                        setTextViewText(R.id.date, "내일의 식단" )
                    }
                    else {
                        setTextViewText(R.id.date, "오늘의 식단")

                    }
                    var sejongBreakfast = widgetData.getString("sejong_breakfast", null)
                    setTextViewText(R.id.breakfast, sejongBreakfast ?: "No title set")

                    var sejongLunch = widgetData.getString("sejong_lunch", null)
                    setTextViewText(R.id.lunch, sejongLunch ?: "No title set")

                    var sejongDinner = widgetData.getString("sejong_dinner", null)
                    setTextViewText(R.id.dinner, sejongDinner ?: "No title set")
                } else {

                    val date = widgetData.getString("happy_date", null)
                    if(hour>=19) {
                        setTextViewText(R.id.date, "내일의 식단")
                    }
                    else {
                        setTextViewText(R.id.date, "오늘의 식단")
                    }

                    val breakfast = widgetData.getString("happy_breakfast", null)
                    setTextViewText(R.id.breakfast, breakfast ?: "No title set")

                    val takeout = widgetData.getString("happy_takeout", null)
                    setTextViewText(R.id.takeout, takeout ?: "No title set")

                    val lunch = widgetData.getString("happy_lunch", null)
                    setTextViewText(R.id.lunch, lunch ?: "No title set")
//
                    val dinner = widgetData.getString("happy_dinner", null)
                    setTextViewText(R.id.dinner, dinner ?: "No title set")
                }
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
