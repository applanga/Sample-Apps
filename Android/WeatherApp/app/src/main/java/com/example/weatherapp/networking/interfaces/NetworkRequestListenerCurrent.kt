package com.example.weatherapp.networking.interfaces

import com.example.weatherapp.networking.modules.current.ApiResponseCurrent

interface NetworkRequestListenerCurrent {
    fun onCompleteNetworkRequestCurrent(apiResponse: ApiResponseCurrent?)
    fun onNetworkRequestError(error: Throwable)
}