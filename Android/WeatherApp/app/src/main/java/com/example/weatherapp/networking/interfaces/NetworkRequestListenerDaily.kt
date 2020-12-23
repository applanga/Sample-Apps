package com.example.weatherapp.networking.interfaces

import com.example.weatherapp.networking.modules.daily.ApiResponseDaily

interface NetworkRequestListenerDaily {
    fun onCompleteNetworkRequestDaily(apiResponse: ApiResponseDaily?)
    fun onNetworkRequestError(error: Throwable)
}