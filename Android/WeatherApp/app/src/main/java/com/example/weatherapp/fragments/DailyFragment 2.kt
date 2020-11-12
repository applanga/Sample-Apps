package com.example.weatherapp.fragments

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.weatherapp.MainActivity
import com.example.weatherapp.adapters.DailyAdapter
import com.example.weatherapp.constants.Settings
import com.example.weatherapp.databinding.FragmentDailyBinding
import com.example.weatherapp.networking.Repository
import com.example.weatherapp.networking.interfaces.NetworkRequestListenerDaily
import com.example.weatherapp.networking.modules.daily.ApiResponseDaily

class DailyFragment(private val activityContext: MainActivity) : Fragment(), NetworkRequestListenerDaily {

    val repository = Repository()
    private lateinit var databinding: FragmentDailyBinding
    private lateinit var recyclerView: RecyclerView

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?): View? {
            databinding = FragmentDailyBinding.inflate(inflater)
            recyclerView = databinding.recyclerViewDaily
            recyclerView.layoutManager = LinearLayoutManager(context)
            return databinding.root
    }

    override fun onResume() {
        super.onResume()
        val sharedPreferences = activityContext.getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE)
        val city = sharedPreferences.getString(Settings.CITY_KEY.toString(), null)
        val units = sharedPreferences.getString(Settings.UNITS_KEY.toString(), null)
        if (city != null && units != null) {
            repository.fetchDailyWeather(this, city, units)
        }
    }

    override fun onCompleteNetworkRequest(apiResponseDaily: ApiResponseDaily?) {
        initUiDaily(apiResponseDaily)
    }

    override fun onNetworkRequestError(error: Throwable) {
        Toast.makeText(context, error.message, Toast.LENGTH_LONG).show()
    }

    fun initUiDaily(apiResponseDaily: ApiResponseDaily?) {
        if (apiResponseDaily != null) {
            recyclerView.adapter = DailyAdapter(activityContext, apiResponseDaily)
        }
    }
}