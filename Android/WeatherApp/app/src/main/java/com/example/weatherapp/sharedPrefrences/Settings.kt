package com.example.weatherapp.sharedPrefrences

data class Settings (
    val city: String,
    val metric: Boolean,
    val imperial: Boolean,
    val darkMode: Boolean,
    val notifications: Boolean,
    val language: String
)