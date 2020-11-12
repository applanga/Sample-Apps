package com.example.weatherapp.networking.modules.daily

import android.content.Context
import com.example.weatherapp.R
import com.google.gson.annotations.SerializedName

data class Day( //NetworkRequestListenerIcon (

		@SerializedName("dt") val dt : Int,
		@SerializedName("main") val main : Main,
		@SerializedName("weather") val weather : List<Weather>,
		@SerializedName("clouds") val clouds : Clouds,
		@SerializedName("wind") val wind : Wind,
		@SerializedName("visibility") val visibility : Int,
		@SerializedName("pop") val pop : Double,
		@SerializedName("rain") val rain : Rain,
		@SerializedName("sys") val sys : Sys,
		@SerializedName("dt_txt") val dt_txt : String
) {
	fun getIcon(context: Context,iconId: String): Int {

		val iconName = when (iconId) {
			"01d", "01n" -> "ic_01d"
			"02d", "03d", "04d", "02n", "03n", "04n" -> "ic_03d"
			"09d", "10d", "09n", "10n" -> "ic_10d"
			"11d", "11n" -> "ic_11d"
			"13d", "13n" -> "ic_13d"
			else -> "ic_01d" // Change this default
		}

		return try {
			context.resources.getIdentifier(iconName, "drawable", context.packageName)
		} catch (error: Throwable) {
			R.drawable.ic_01d // app icon
		}

//		return R.drawable.ic_01d

	}
}