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

                val calendar = Calendar.getInstance()
                val hour = calendar.get(Calendar.HOUR_OF_DAY)
                val minute = calendar.get(Calendar.MINUTE)
                val is_sejong = widgetData.getBoolean("is_sejong", true )

                if(is_sejong) {
                    val sejongDate = widgetData.getString("sejong_date", null)


                    if (hour < 7 || hour == 7 && minute <= 30) {
                        setTextViewText(R.id.title, "오늘의 조식" )
                        val sejongBreakfast = widgetData.getString("sejong_breakfast", null)
                        setTextViewText(R.id.meal, sejongBreakfast ?: "No title set")
                    }
                    if (hour >= 9) {
                        setTextViewText(R.id.title, "오늘의 중식" )
                        val sejongLunch = widgetData.getString("sejong_lunch", null)
                        setTextViewText(R.id.meal, sejongLunch ?: "No title set")
                    }

                    if (hour > 13 || hour == 13 && minute >= 30) {
                        setTextViewText(R.id.title, "오늘의 석식")
                        val sejongDinner = widgetData.getString("sejong_dinner", null)
                        setTextViewText(R.id.meal, sejongDinner ?: "No title set")
                    }

                    if (hour > 18 || hour == 18 && minute >= 30) {
                        setTextViewText(R.id.title, "내일의 조식")
                        val sejongNextBreakfast = widgetData.getString("sejong_breakfast", null)
                        setTextViewText(R.id.meal, sejongNextBreakfast ?: "No title set")
                    }
                }
                else {
                    val date = widgetData.getString("happy_date", null)

                    if(hour<9 || hour==9 && minute<=30) {
                        setTextViewText(R.id.title, "오늘의 조식" )
                        val breakfast = widgetData.getString("happy_breakfast", null)
                        setTextViewText(R.id.meal, breakfast ?: "앗 조금만 기다려주세용")

                        val takeout = widgetData.getString("happy_takeout", null)
                        setTextViewText(R.id.takeout, takeout ?: "식단이 준비되는대로 알려드릴게요")

                    }
                    if(hour<14) {
                        setTextViewText(R.id.title, "오늘의 중식" )

                        val lunch = widgetData.getString("happy_lunch", null)
                        setTextViewText(R.id.meal, lunch ?: "No title set")
                    }


                    if (hour<19) {
                        setTextViewText(R.id.title, "오늘의 석식")

                        val dinner = widgetData.getString("happy_dinner", null)
                        setTextViewText(R.id.meal, dinner ?: "No title set")
                    }

                    if(hour>=19) {
                        setTextViewText(R.id.title, "내일의 조식")
                        val breakfast = widgetData.getString("happy_breakfast", null)
                        setTextViewText(R.id.meal, breakfast ?: "No title set")

                        val takeout = widgetData.getString("happy_takeout", null)
                        setTextViewText(R.id.takeout, takeout ?: "")
                    }


                }




            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }


}
