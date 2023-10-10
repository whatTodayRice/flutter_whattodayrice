package com.example.flutter_whattodayrice

import android.annotation.TargetApi
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.os.Build
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Implementation of App Widget functionality.
 */
class MealWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)

            val views = RemoteViews(context.packageName, R.layout.meal_widget).apply {

                val is_sejong = widgetData.getBoolean("is_sejong",true)
                if (is_sejong) {
                    var sejong_date = widgetData.getString("sejong_date",null)
                    setTextViewText(R.id.date, sejong_date ?: "no date set")

                    val sejong_breakfast = widgetData.getString("sejong_breakfast",null)
                    setTextViewText(R.id.breakfast, sejong_breakfast ?: "No title set")

                    val sejong_lunch = widgetData.getString("sejong_lunch",null)
                    setTextViewText(R.id.lunch, sejong_lunch ?: "No title set")

                    setTextViewText(R.id.takeout, null);
                    val sejong_dinner = widgetData.getString("sejong_dinner",null)
                    setTextViewText(R.id.dinner, sejong_dinner ?: "No title set")
                }
                else {
                    var date = widgetData.getString("happy_date",null)
                    setTextViewText(R.id.date, date ?: "no date set")

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

            appWidgetManager.updateAppWidget(appWidgetId,views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

//internal fun updateAppWidget(
//    context: Context,
//    appWidgetManager: AppWidgetManager,
//    appWidgetId: Int
//) {
//    val widgetText = context.getString(R.string.appwidget_text)
//    // Construct the RemoteViews object
//    val views = RemoteViews(context.packageName, R.layout.meal_widget)
//    views.setTextViewText(R.id.appwidget_text, widgetText)
//    // Instruct the widget manager to update the widget
//    appWidgetManager.updateAppWidget(appWidgetId, views)
//}