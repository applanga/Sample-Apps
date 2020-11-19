package com.example.weatherapp.fragments

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.example.weatherapp.MainActivity
import com.example.weatherapp.constants.Settings
import com.example.weatherapp.databinding.FragmentCurrentBinding
import com.example.weatherapp.networking.Repository
import com.example.weatherapp.networking.interfaces.NetworkRequestListenerCurrent
import com.example.weatherapp.networking.modules.current.ApiResponseCurrent

class CurrentFragment(val activityContext: MainActivity) : Fragment(), NetworkRequestListenerCurrent {

    private val repository = Repository()
    private lateinit var databinding: FragmentCurrentBinding

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?): View? {
            databinding = FragmentCurrentBinding.inflate(inflater)
            return databinding.root
    }

    override fun onResume() {
        super.onResume()
        val sharedPreferences = activityContext.getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE)
        val city = sharedPreferences.getString(Settings.CITY_KEY.toString(), null)
        val units = sharedPreferences.getString(Settings.UNITS_KEY.toString(), null)
        if (city != null && units != null) {
            repository.fetchCurrentWeather(this, city, units)
        }
    }

    override fun onCompleteNetworkRequest(apiResponseCurrent: ApiResponseCurrent?) {
        initUiCurrent(apiResponseCurrent)
    }

    override fun onNetworkRequestError(error: Throwable) {
        Toast.makeText(context, error.message, Toast.LENGTH_LONG).show()
    }

    private fun initUiCurrent(apiResponseCurrent: ApiResponseCurrent?) {
        if (apiResponseCurrent != null) {
            databinding.currentWeather = apiResponseCurrent
        }
    }

}