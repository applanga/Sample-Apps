package com.example.weatherapp.utils

import java.text.SimpleDateFormat
import java.util.*

object DateHelper {

    private fun getDayName(givenDay: Int? = null): String {
        return when (givenDay ?: Calendar.getInstance().get(Calendar.DAY_OF_WEEK)) {
            1 -> "Sunday"
            2 -> "Monday"
            3 -> "Tuesday"
            4 -> "Wednesday"
            5 -> "Thrusday"
            6 -> "Friday"
            7 -> "Saturday"
            else -> "N/A"
        }
    }

    private fun getMonthName() {

    }

    fun getCurrentDateTTN(): String {
//        val day = SimpleDateFormat("EEEE", Locale.ENGLISH).format(System.currentTimeMillis())
        val month = SimpleDateFormat("LLLL").format(Calendar.getInstance().time)
        val date = Calendar.getInstance().get(Calendar.DAY_OF_MONTH)

        return "${getDayName()}, $month $date"
    }
}