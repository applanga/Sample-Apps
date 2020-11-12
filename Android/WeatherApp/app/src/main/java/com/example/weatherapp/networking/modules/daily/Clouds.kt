package com.example.weatherapp.networking.modules.daily

import com.google.gson.annotations.SerializedName

data class Clouds (

	@SerializedName("all") val all : Int
)