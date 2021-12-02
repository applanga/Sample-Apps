package com.applanga.weathersample.classes

import com.applanga.android.ApplangaApplication

class WeatherAppApplication : ApplangaApplication() {

    companion object {
        lateinit var app : WeatherAppApplication
    }

    lateinit var sharedPrefrencesManager: SharedPrefrencesManager

    override fun onCreate() {
        super.onCreate()

        sharedPrefrencesManager = SharedPrefrencesManager(this)

        app = this
    }

}