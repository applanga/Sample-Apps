package com.example.weatherapp.utils

import android.content.res.Resources
import android.widget.TextView
import androidx.databinding.BindingAdapter
import com.example.weatherapp.R
import kotlin.math.roundToInt

object FragmentBindingAdapter {
    @JvmStatic
    @BindingAdapter("doubleToInt")
    fun doubleToInt(textView : TextView, temp: Double) {
        textView.text = temp.roundToInt().toString() + "° "
    }

    @JvmStatic
    @BindingAdapter("getDescriptionString")
    fun getDescriptionString(textView: TextView, descriptionId: String) {
        textView.text = when (descriptionId) {
            "01d", "01n" -> Resources.getSystem().getString(R.string.description_clear_sky)
            "02d", "02n" -> Resources.getSystem().getString(R.string.description_few_clouds)
            "03d", "03n" -> Resources.getSystem().getString(R.string.description_scattered_clouds)
            "04d", "04n" -> Resources.getSystem().getString(R.string.description_broken_clouds)
            "09d", "09n" -> Resources.getSystem().getString(R.string.description_shower_rain)
            "10d", "10n" -> Resources.getSystem().getString(R.string.description_rain)
            "11d", "11n" -> Resources.getSystem().getString(R.string.description_thunderstorm)
            "13d", "13n" -> Resources.getSystem().getString(R.string.description_snow)
            "50d", "50n" -> Resources.getSystem().getString(R.string.description_mist)
            else -> Resources.getSystem().getString(R.string.not_available)
        }
    }
}