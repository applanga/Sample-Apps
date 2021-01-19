package com.example.weatherapp

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.MotionEvent
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.MediatorLiveData
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.navigateUp
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.applanga.android.Applanga
import com.example.weatherapp.classes.SharedPrefrencesManager.Keys
import com.example.weatherapp.classes.WeatherAppApplication
import com.example.weatherapp.databinding.ActivityMainBinding
import com.example.weatherapp.networking.Repository
import com.example.weatherapp.networking.interfaces.NetworkRequestListenerCurrent
import com.example.weatherapp.networking.interfaces.NetworkRequestListenerDaily
import com.example.weatherapp.networking.modules.current.ApiResponseCurrent
import com.example.weatherapp.networking.modules.daily.ApiResponseDaily
import com.google.android.material.navigation.NavigationView


class MainActivity : AppCompatActivity() ,
    NetworkRequestListenerCurrent,
    NetworkRequestListenerDaily {

    private val repository = Repository()

    var currentWeather : MediatorLiveData<ApiResponseCurrent> = MediatorLiveData()
    var dailyWeather : MediatorLiveData<ApiResponseDaily> = MediatorLiveData()

    private lateinit var binding: ActivityMainBinding
    private lateinit var appBarConfiguration: AppBarConfiguration

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_main)
    }

    override fun onResume() {
        super.onResume()
        initApp()
    }

    private fun initApp() {
        setInitialSettings()
        initNavigation()
        initUiHeader()
        getApiData()
    }

    private fun getApiData() {
        val settings = WeatherAppApplication.app.sharedPrefrencesManager
        val city = settings.getString(Keys.CITY_KEY.toString(), "New York")
        val unit = settings.getString(Keys.UNITS_KEY.toString(), "metric")

        if (city != null && unit != null) {
            repository.fetchCurrentWeather(this, city, unit)
            repository.fetchDailyWeather(this, city, unit)
        }
    }

    override fun onCompleteNetworkRequestCurrent(apiResponse: ApiResponseCurrent?) {
        if (apiResponse != null) {
            currentWeather.apply {
                value = apiResponse
            }
        }
    }

    override fun onCompleteNetworkRequestDaily(apiResponse: ApiResponseDaily?) {
        if (apiResponse != null) {
            dailyWeather.apply {
                value = apiResponse
            }
        }
    }

    override fun onNetworkRequestError(error: Throwable) {
        Toast.makeText(this, error.message, Toast.LENGTH_LONG).show()
    }

    override fun onSupportNavigateUp(): Boolean {
        val navController = findNavController(R.id.nav_host_fragment)
        return navController.navigateUp(appBarConfiguration) || super.onSupportNavigateUp()
    }

    private fun initNavigation() {

        val navController = findNavController(R.id.nav_host_fragment)

        binding.apply {
            setSupportActionBar(mainContent.toolbar)
            appBarConfiguration = AppBarConfiguration(
                setOf(
                    R.id.nav_home,
                    R.id.nav_daily,
                    R.id.nav_about,
                    R.id.nav_settings
                ), drawerLayout
            )
            setupActionBarWithNavController(navController, appBarConfiguration)
            navView.setupWithNavController(navController)

            //set initial title to home page
            mainContent.toolbar.title = getString(R.string.menu_home)

            //add listner for when the navigation changes
            navController.addOnDestinationChangedListener { _, destination, _ ->
                when(destination.id){
                    R.id.nav_home -> mainContent.toolbar.title = getString(R.string.menu_home)
                    R.id.nav_daily -> mainContent.toolbar.title = getString(R.string.menu_daily)
                    R.id.nav_about -> mainContent.toolbar.title = getString(R.string.menu_about)
                    R.id.nav_settings -> mainContent.toolbar.title = getString(R.string.menu_settings)
                }
            }
        }

        //localise the nav menu
        val navView = findViewById<NavigationView>(R.id.nav_view)
        Applanga.localizeMenu(R.menu.activity_main_drawer, navView.menu)
    }

    private fun setInitialSettings() {
        val settings = WeatherAppApplication.app.sharedPrefrencesManager

        if (settings.getBoolean(Keys.FIRST_RUN_KEY.toString(), true)) {
            settings.let {
                it.putString(Keys.CITY_KEY.toString(), "New York")
                it.putString(Keys.UNITS_KEY.toString(), "metric")
                it.putString(Keys.LANGUAGE_KEY.toString(), "en")
                it.putInt(Keys.DAYS_NUMBER_KEY.toString(), 5)
                it.putBoolean(Keys.FIRST_RUN_KEY.toString(), false)
            }
        }
    }

    private fun initUiHeader() {
        val headerView = binding.navView.getHeaderView(0)
        val applangaUrl = "https://www.applanga.com"
        headerView.setOnClickListener {
            val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse(applangaUrl))
            startActivity(browserIntent)
        }
    }

    //     --- Allow Applanga's draft mode --- //
    override fun dispatchTouchEvent(ev: MotionEvent?): Boolean {
        Applanga.dispatchTouchEvent(ev, this)
        return super.dispatchTouchEvent(ev)
    }

}