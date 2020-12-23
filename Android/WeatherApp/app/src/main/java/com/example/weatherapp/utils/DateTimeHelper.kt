package com.example.weatherapp.utils

import android.content.res.Resources
import com.example.weatherapp.R
import java.text.SimpleDateFormat
import java.util.*
import java.util.Calendar.*

class DateTimeHelper {

    private val system = Resources.getSystem()

    private fun getDayNameFromInt(dayNumber: Int? = null): String {
        return when (dayNumber ?: getInstance().get(DAY_OF_WEEK)) {
            1 -> system.getString(R.string.days_sunday)
            2 -> system.getString(R.string.days_monday)
            3 -> system.getString(R.string.days_tuesday)
            4 -> system.getString(R.string.days_wednesday)
            5 -> system.getString(R.string.days_thursday)
            6 -> system.getString(R.string.days_friday)
            7 -> system.getString(R.string.days_saturday)
            else -> system.getString(R.string.not_available)
        }
    }

    private fun getDayNameFromString(dayNumber: String): String {
        return when (dayNumber) {
            "Sunday" -> system.getString(R.string.days_sunday)
            "Monday" -> system.getString(R.string.days_monday)
            "Tuesday" -> system.getString(R.string.days_tuesday)
            "Wednesday" -> system.getString(R.string.days_wednesday)
            "Thursday" -> system.getString(R.string.days_thursday)
            "Friday" -> system.getString(R.string.days_friday)
            "Saturday" -> system.getString(R.string.days_saturday)
            else -> system.getString(R.string.not_available)
        }
    }

    private fun getMonthName(monthNumber: String? = null) : String {
        return when(monthNumber ?: SimpleDateFormat("LLLL").format(getInstance().time)) {
            "January" -> system.getString(R.string.month_january)
            "February" -> system.getString(R.string.month_february)
            "March" -> system.getString(R.string.month_march)
            "April" -> system.getString(R.string.month_april)
            "May" -> system.getString(R.string.month_may)
            "June" -> system.getString(R.string.month_june)
            "July" -> system.getString(R.string.month_july)
            "August" -> system.getString(R.string.month_august)
            "September" -> system.getString(R.string.month_september)
            "October" -> system.getString(R.string.month_october)
            "November" -> system.getString(R.string.month_november)
            "December" -> system.getString(R.string.month_december)
            else -> system.getString(R.string.not_available)
        }
    }

    fun getCurrentDate(): String {
//        val day = SimpleDateFormat("EEEE", Locale.ENGLISH).format(System.currentTimeMillis())
//        val month = SimpleDateFormat("LLLL").format(getInstance().time)
        val date = getInstance().get(DAY_OF_MONTH)

        return "${getDayNameFromInt()}, ${getMonthName()} $date"
    }

    fun getFullDate(givenDate: String): String {
        val format = SimpleDateFormat("yyyy-MM-dd").parse(givenDate)
        val dayName = SimpleDateFormat("EEEE", Locale.ENGLISH).format(format)
        val monthName = SimpleDateFormat("LLLL").format(getInstance().time)

        return "${getDayNameFromString(dayName)}, ${getMonthName(monthName)} ${givenDate.substring(8, 10)}"
    }
}