package com.example.weatherapp.fragments

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.example.weatherapp.MainActivity
import com.example.weatherapp.constants.Settings
import com.example.weatherapp.databinding.FragmentSettingsBinding

class SettingsFragment(private val activityContext: MainActivity) : Fragment() {

    private lateinit var databinding: FragmentSettingsBinding

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?): View? {
                databinding = FragmentSettingsBinding.inflate(inflater)
                initUi()
                databinding.settingsSaveBtn.setOnClickListener {
                    saveSetttings()
                }
                return databinding.root
    }

    override fun onResume() {
        super.onResume()
        initUi()
    }


    private fun saveSetttings() {
        val cityInput: String = databinding.settingsCity.text.toString()
        val pickedSystem: String = if (databinding.settingsImperial.isChecked) "imperial" else "metric"
        val isDarkmode: Boolean = databinding.settingsDarkModeSwitch.isChecked
        val notificationsAllowed = databinding.settingsNotificationsSwitch.isChecked

        val sharedPreferences = activityContext.getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE)
        sharedPreferences?.edit()?.apply{
            putString(Settings.CITY_KEY.toString(), cityInput)
            putString(Settings.UNITS_KEY.toString(), pickedSystem)
            putBoolean(Settings.DARKMODE_KEY.toString(), isDarkmode)
            putBoolean(Settings.NOTIFICATIONS_KEY.toString(), notificationsAllowed)
        }?.apply()

        Toast.makeText(context, "Saved selected preferences", Toast.LENGTH_LONG).show()
    }

    private fun initUi() {

        val sharedPreferences = activityContext.getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE)
        val cityString = sharedPreferences?.getString(Settings.CITY_KEY.toString(), null)
        val systemBoolean = sharedPreferences?.getString(Settings.UNITS_KEY.toString(), null) != "metric"
        val darkmodeBoolean = sharedPreferences!!.getBoolean(Settings.DARKMODE_KEY.toString(), false)
        val notificationsBoolean = sharedPreferences!!.getBoolean(Settings.NOTIFICATIONS_KEY.toString(), true)

        if (systemBoolean) {
            databinding.settingsImperial.isChecked = true
        } else {
            databinding.settingsMetric.isChecked = true
        }
        databinding.settingsCity.setText(cityString, TextView.BufferType.EDITABLE)
        databinding.settingsDarkModeSwitch.isChecked = darkmodeBoolean
        databinding.settingsNotificationsSwitch.isChecked = notificationsBoolean

    }

}