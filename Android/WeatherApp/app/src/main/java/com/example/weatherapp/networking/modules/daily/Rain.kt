package com.example.weatherapp.networking.modules.daily

import com.google.gson.annotations.SerializedName

data class Rain (

		@SerializedName("3h") val threeHours : Double
)