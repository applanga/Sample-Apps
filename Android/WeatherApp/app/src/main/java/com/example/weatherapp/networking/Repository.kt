package com.example.weatherapp.networking

import com.example.weatherapp.networking.interfaces.NetworkRequestListenerCurrent
import com.example.weatherapp.networking.interfaces.NetworkRequestListenerDaily
import com.example.weatherapp.networking.modules.current.ApiResponseCurrent
import com.example.weatherapp.networking.modules.daily.ApiResponseDaily
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


class Repository() {

    companion object {
        val appId = "aebbd2fcfb9380df055be33fa8989c94"
        val baseUrl = "https://api.openweathermap.org/"
    }

    private val retrofit = Retrofit.Builder()
        .baseUrl(baseUrl)
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    private val service: WeatherApi = retrofit.create(WeatherApi::class.java)

    fun fetchCurrentWeather(networkRequestListener: NetworkRequestListenerCurrent, city: String, units: String) {
        service.getCurrent(appId, units, city).enqueue(object : Callback<ApiResponseCurrent?> {
            override fun onResponse(call: Call<ApiResponseCurrent?>, response: Response<ApiResponseCurrent?>) {
                networkRequestListener.onCompleteNetworkRequest(response.body())
            }

            override fun onFailure(call: Call<ApiResponseCurrent?>, error: Throwable) {
                networkRequestListener.onNetworkRequestError(error)
            }
        })
    }

    fun fetchDailyWeather(networkRequestListener: NetworkRequestListenerDaily, city: String, units: String) {
        service.getDaily(appId, units, city).enqueue(object : Callback<ApiResponseDaily?> {
            override fun onResponse(call: Call<ApiResponseDaily?>, response: Response<ApiResponseDaily?>) {
                networkRequestListener.onCompleteNetworkRequest(response.body())
            }

            override fun onFailure(call: Call<ApiResponseDaily?>, error: Throwable) {
                networkRequestListener.onNetworkRequestError(error)
            }
        })
    }

}

//url = "https://api.openweathermap.org/data/2.5/weather?q=berlin&units=metric&appid=aebbd2fcfb9380df055be33fa8989c94"
