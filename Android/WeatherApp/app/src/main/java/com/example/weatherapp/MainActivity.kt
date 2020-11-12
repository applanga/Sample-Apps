package com.example.weatherapp

import android.app.Activity
import android.content.Context
import android.content.res.Configuration
import android.os.Bundle
import android.util.Log
import android.view.MotionEvent
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import com.applanga.android.Applanga
import com.example.weatherapp.constants.Settings
import com.example.weatherapp.databinding.ActivityMainBinding
import com.example.weatherapp.fragments.CurrentFragment
import com.example.weatherapp.fragments.DailyFragment
import com.example.weatherapp.fragments.SettingsFragment
import java.util.*


class MainActivity : AppCompatActivity() {

    companion object {
        const val START_FRAGMENT = "START_FRAGMENT"
        const val ACTION_KEY = "ACTION_KEY"
    }

    private lateinit var databinding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.i("applanga test", Applanga.getString(R.string.app_name, "default"))

        databinding = DataBindingUtil.setContentView(this, R.layout.activity_main)

        val currentFragment = CurrentFragment(this)
        val dailyFragment = DailyFragment(this)
        val settingsFragment = SettingsFragment(this)

        val extras = intent.extras
        val action = extras?.get(ACTION_KEY)
        when (action) {
            START_FRAGMENT -> {
                setFragment(dailyFragment)
            }
        }

        databinding.bottomNavigation.setOnNavigationItemSelectedListener {
            when (it.itemId) {
                R.id.current_btn -> setFragment(currentFragment)
                R.id.daily_btn -> setFragment(dailyFragment)
                R.id.settings_btn -> setFragment(settingsFragment)
                else -> setFragment(currentFragment)
            }
            true
        }

        setInitialSettings()
        if (action == null) {
            setFragment(currentFragment)
        }

        val channelId = "CHANNEL_ID"
        val notificationId = 1
        val title = "Thinking about going to the beach?"
        val description = "Check out the weather for today before heading out!"
        val allowNotification = this.getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE).getBoolean(Settings.NOTIFICATIONS_KEY.toString(), true)

        val notification = Notification(this, allowNotification, channelId, notificationId, title, description)
        notification.createNotificationChannel()
        notification.sendNotification()
    }

    private fun setFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction().apply {
            replace(R.id.test_fragment, fragment)
            addToBackStack(null)
            commit()
        }
    }

    private fun setInitialSettings() {
        this.getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE).edit().apply{
                        // Replace hardcoded location when geolocation added
                putString(Settings.CITY_KEY.toString(), "Berlin")
                putString(Settings.UNITS_KEY.toString(), "metric")
                putBoolean(Settings.DARKMODE_KEY.toString(), false)
                // Set to true to activate notifications
                putBoolean(Settings.NOTIFICATIONS_KEY.toString(), false)
        }.apply()

    }

//     --- Allow Applanga's draft mode --- //
    override fun dispatchTouchEvent(ev: MotionEvent?): Boolean {
        Applanga.dispatchTouchEvent(ev, this)
        return super.dispatchTouchEvent(ev)
    }
}

