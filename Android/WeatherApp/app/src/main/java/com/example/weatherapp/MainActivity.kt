package com.example.weatherapp

import android.content.Context
import android.os.Bundle
import android.view.MenuItem
import android.view.MotionEvent
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.GravityCompat
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.navigation.NavController
import androidx.navigation.findNavController
import androidx.navigation.ui.NavigationUI
import com.applanga.android.Applanga
import com.example.weatherapp.constants.Settings
import com.example.weatherapp.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    companion object {
        const val START_FRAGMENT = "START_FRAGMENT"
        const val ACTION_KEY = "ACTION_KEY"
    }

    private lateinit var binding: ActivityMainBinding
    private lateinit var navController: NavController

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = DataBindingUtil.setContentView(this, R.layout.activity_main)

        setSupportActionBar(binding.toolbar)
        supportActionBar?.setDisplayShowHomeEnabled(true)

        navController = findNavController(R.id.navHostFragment)
        navController.setGraph(R.navigation.navigation_graph)

//        val appBarConfigurator = AppBarConfiguration.Builder(
//                R.id.currentFragment, R.id.dailyFragment, R.id.settingsFragment
//        ).setOpenableLayout(binding.drawerLayout).build()
//
//        setupActionBarWithNavController(navController, appBarConfigurator)
//        binding.navView.setupWithNavController(navController)

        NavigationUI.setupActionBarWithNavController(this, navController, binding.drawerLayout)
        NavigationUI.setupWithNavController(binding.navView, navController)

        initNavigation()
        setInitialSettings()
        initNotification()
    }

    override fun onSupportNavigateUp(): Boolean {
        return navController.navigateUp()
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.itemId == android.R.id.home && binding.drawerLayout.isDrawerOpen(GravityCompat.START)) {
            binding.drawerLayout.closeDrawer(GravityCompat.START)
        } else {
            binding.drawerLayout.openDrawer(GravityCompat.START)
        }
        return super.onOptionsItemSelected(item)
    }

    
    private fun setFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction().apply {
            replace(R.id.navHostFragment, fragment)
            addToBackStack(null)
            commit()
        }
    }

    private fun setInitialSettings() {
        val sharedPreferences = this.getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE)

        if (sharedPreferences.getString(Settings.CITY_KEY.toString(), null) != null) {
            return
        }

        sharedPreferences.edit().apply{
                        // Replace hardcoded location when geolocation added
                putString(Settings.CITY_KEY.toString(), "Berlin")
                putString(Settings.UNITS_KEY.toString(), "metric")
                putBoolean(Settings.DARKMODE_KEY.toString(), false)
                putBoolean(Settings.NOTIFICATIONS_KEY.toString(), false)
                putString(Settings.LANGUAGE_KEY.toString(), "en")
        }.apply()

    }

    private fun initNotification() {
        val channelId = "CHANNEL_ID"
        val notificationId = 1
        val title = "Thinking about going to the beach?"
        val description = "Check out the weather for today before heading out!"
        val allowNotification = this.getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE).getBoolean(Settings.NOTIFICATIONS_KEY.toString(), true)

        val notification = Notification(this, allowNotification, channelId, notificationId, title, description)
        notification.createNotificationChannel()
        notification.sendNotification()
    }

    private fun initNavigation() {
//        val currentFragment = CurrentFragment(this)
//        val dailyFragment = DailyFragment(this)
//        val settingsFragment = SettingsFragment(this)
//
//        val extras = intent.extras
//        val action = extras?.get(ACTION_KEY)
//        when (action) {
//            START_FRAGMENT -> {
//                setFragment(dailyFragment)
//            }
//        }
//
//        binding.bottomNavigation.setOnNavigationItemSelectedListener {
//            when (it.itemId) {
//                R.id.current_btn -> setFragment(currentFragment)
//                R.id.daily_btn -> setFragment(dailyFragment)
//                R.id.settings_btn -> setFragment(settingsFragment)
//                else -> setFragment(currentFragment)
//            }
//            true
//        }
//
//        if (action == null) {
//            setFragment(currentFragment)
//        }
    }

//     --- Allow Applanga's draft mode --- //
    override fun dispatchTouchEvent(ev: MotionEvent?): Boolean {
        Applanga.dispatchTouchEvent(ev, this)
        return super.dispatchTouchEvent(ev)
    }
}

