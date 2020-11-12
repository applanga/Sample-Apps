package com.example.weatherapp.networking.modules.daily

import com.google.gson.annotations.SerializedName

data class Sys (

	@SerializedName("pod") val pod : String
)