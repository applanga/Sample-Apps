package com.applanga.weathersample.networking.modules.current

import com.google.gson.annotations.SerializedName


data class Wind (

		@SerializedName("speed") val speed : Double,
		@SerializedName("deg") val deg : Int
)