package com.example.weatherapp.fragments

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.applanga.android.Applanga
import com.example.weatherapp.R
import com.example.weatherapp.constants.Settings
import com.example.weatherapp.databinding.FragmentSettingsBinding

class SettingsFragment : Fragment() {

    private lateinit var binding: FragmentSettingsBinding
    private val spinnerOptions = arrayOf("English", "German", "French")

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?): View? {
                binding = FragmentSettingsBinding.inflate(inflater)
                initUi()
                return binding.root
    }

    override fun onResume() {
        super.onResume()
        initUi()
    }


    private fun saveSetttings() {
        val cityInput: String = binding.settingsCity.text.toString()
        val pickedSystem: String = if (binding.settingsImperial.isChecked) "imperial" else "metric"
        val isDarkmode: Boolean = binding.settingsDarkModeSwitch.isChecked
        val notificationsAllowed = binding.settingsNotificationsSwitch.isChecked
        val iso = when(binding.spinner.selectedItem.toString()) {
            "English" -> "en"
            "German" -> "de"
            "French" -> "fr"
            else -> "en"
        }

        val sharedPreferences = requireActivity().getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE)
        sharedPreferences?.edit()?.apply{
            putString(Settings.CITY_KEY.toString(), cityInput)
            putString(Settings.UNITS_KEY.toString(), pickedSystem)
            putBoolean(Settings.DARKMODE_KEY.toString(), isDarkmode)
            putBoolean(Settings.NOTIFICATIONS_KEY.toString(), notificationsAllowed)
            putString(Settings.LANGUAGE_KEY.toString(), iso)
        }?.apply()

        Toast.makeText(context, "Saved selected preferences", Toast.LENGTH_LONG).show()

        Applanga.setLanguage(iso)

        requireActivity().finish()
        requireActivity().startActivity(requireActivity().intent)
    }

    private fun initUi() {

        val sharedPreferences = requireActivity().getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE)
        val cityString = sharedPreferences?.getString(Settings.CITY_KEY.toString(), null)
        val systemBoolean = sharedPreferences?.getString(Settings.UNITS_KEY.toString(), null) != "metric"
        val darkmodeBoolean = sharedPreferences!!.getBoolean(Settings.DARKMODE_KEY.toString(), false)
        val notificationsBoolean = sharedPreferences!!.getBoolean(Settings.NOTIFICATIONS_KEY.toString(), true)
        val languagePosition = when (sharedPreferences?.getString(Settings.LANGUAGE_KEY.toString(), null)) {
            "en" -> 0
            "de" -> 1
            "fr" -> 2
            else -> 0
        }

        if (systemBoolean) {
            binding.settingsImperial.isChecked = true
        } else {
            binding.settingsMetric.isChecked = true
        }

        binding.apply {
            settingsCity.setText(cityString, TextView.BufferType.EDITABLE)
            settingsDarkModeSwitch.isChecked = darkmodeBoolean
            settingsNotificationsSwitch.isChecked = notificationsBoolean
            spinner.apply {
                adapter = ArrayAdapter(
                        requireActivity(),
                        R.layout.spinner_language_item,
                        spinnerOptions
                )
                (adapter as ArrayAdapter<*>).setDropDownViewResource(R.layout.spinner_dropdown_item)
                setSelection(languagePosition)
            }
            settingsSaveBtn.setOnClickListener {
                saveSetttings()
            }
        }
    }

}