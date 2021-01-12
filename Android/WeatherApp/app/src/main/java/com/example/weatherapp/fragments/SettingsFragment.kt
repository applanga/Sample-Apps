package com.example.weatherapp.fragments

import android.content.Context
import android.content.res.Resources
import android.os.Bundle
import android.view.KeyEvent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.ArrayAdapter
import android.widget.TextView
import android.widget.Toast
import com.applanga.android.Applanga
import com.example.weatherapp.R
import com.example.weatherapp.classes.SharedPrefrencesManager
import com.example.weatherapp.classes.SharedPrefrencesManager.Keys
import com.example.weatherapp.classes.WeatherAppApplication
import com.example.weatherapp.databinding.FragmentSettingsBinding
import com.example.weatherapp.networking.Repository
import com.example.weatherapp.networking.interfaces.NetworkRequestListenerCurrent
import com.example.weatherapp.networking.modules.current.ApiResponseCurrent


class SettingsFragment : androidx.fragment.app.Fragment() {

    lateinit var binding: FragmentSettingsBinding
    lateinit var settings: SharedPrefrencesManager

    private val languageOptions = Resources.getSystem().getStringArray(R.array.settings_language_options)

    private val daysOptions = arrayOf("1", "2", "3", "4", "5")

    private val repository = Repository()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentSettingsBinding.inflate(inflater)
        initUiSettings()
        return binding.root
    }

    private fun initUiSettings() {
        initLanguageSpinner()
        initDaysSpinner()

        settings = WeatherAppApplication.app.sharedPrefrencesManager

        binding.apply {

            settingsCity.setText(
                settings.getString(Keys.CITY_KEY.toString(), null),
                TextView.BufferType.EDITABLE
            )
            if (settings.getString(Keys.UNITS_KEY.toString(), null) == "metric") {
                settingsMetric.isChecked = true
            } else {
                settingsImperial.isChecked = true
            }
            settingsLanguageSpinner.setSelection(
                when (settings.getString(
                    Keys.LANGUAGE_KEY.toString(),
                    null
                )) {
                    "en" -> 0
                    "de" -> 1
                    "fr" -> 2
                    else -> 0
                }
            )
            settingsDaysSpinner.setSelection(
                settings.getInt(
                    Keys.DAYS_NUMBER_KEY.toString(),
                    5
                ) - 1
            )

            settingsSaveBtn.setOnClickListener {
                verifyApiResponse()
            }
            settingsCity.setOnKeyListener { view, keyCode, _ -> hideSoftKeyboardOnEnter(view, keyCode) }
        }

    }

    private fun hideSoftKeyboardOnEnter(view: View, keyCode: Int): Boolean {
        if (keyCode == KeyEvent.KEYCODE_ENTER) {
            val inputMethodManager = requireContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            inputMethodManager.hideSoftInputFromWindow(view.windowToken, 0)
            return true
        }
        return false
    }

    private fun verifyApiResponse() {
        val listener = object : NetworkRequestListenerCurrent {
            override fun onCompleteNetworkRequestCurrent(apiResponse: ApiResponseCurrent?) {
                saveSettings()
            }

            override fun onNetworkRequestError(error: Throwable) {
                Toast.makeText(context, getString(R.string.settings_error_toast), Toast.LENGTH_LONG).show()
            }
        }

        repository.fetchCurrentWeather(listener, binding.settingsCity.text.toString(), "metric")
    }

    private fun saveSettings() {

        val city = binding.settingsCity.text.toString()
        val measurement = if (binding.settingsMetric.isChecked) "metric" else "imperial"
        val isoCode = when(binding.settingsLanguageSpinner.selectedItem.toString()) {
            "English" -> "en"
            "German" -> "de"
            "French" -> "fr"
            else -> "en"
        }
        val displayedDays = binding.settingsDaysSpinner.selectedItem.toString().toInt()

        WeatherAppApplication.app.sharedPrefrencesManager.let {
            it.putString(Keys.CITY_KEY.toString(), city)
            it.putString(Keys.UNITS_KEY.toString(), measurement)
            it.putString(Keys.LANGUAGE_KEY.toString(), isoCode)
            it.putInt(Keys.DAYS_NUMBER_KEY.toString(), displayedDays)
        }

        Applanga.setLanguage(isoCode)

        requireActivity().finish()
        requireActivity().startActivity(requireActivity().intent)

        Toast.makeText(context, getString(R.string.settings_saved_toast), Toast.LENGTH_LONG).show()
    }

    private fun initLanguageSpinner() {
        binding.settingsLanguageSpinner.apply {
            adapter = ArrayAdapter(
                requireActivity(),
                R.layout.spinner_item_settings_menu,
                languageOptions
            )
            (adapter as ArrayAdapter<*>).setDropDownViewResource(R.layout.spinner_item_settings_dropdown)
            setSelection(0)
        }
    }

    private fun initDaysSpinner() {
        binding.settingsDaysSpinner.apply {
            adapter = ArrayAdapter(
                requireActivity(),
                R.layout.spinner_item_settings_menu,
                daysOptions
            )
            (adapter as ArrayAdapter<*>).setDropDownViewResource(R.layout.spinner_item_settings_dropdown)
            setSelection(0)
        }
    }
}