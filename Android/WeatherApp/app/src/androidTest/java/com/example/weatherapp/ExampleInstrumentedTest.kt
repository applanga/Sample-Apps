package com.example.weatherapp

import android.content.Intent
import android.os.SystemClock
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.contrib.DrawerActions
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.internal.runner.junit4.AndroidJUnit4ClassRunner
import com.applanga.android.Applanga
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import java.util.*

/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4ClassRunner::class)
class ExampleInstrumentedTest {

    @get:Rule
    var activityRule: ActivityScenarioRule<MainActivity>
            = ActivityScenarioRule(MainActivity::class.java)

    @Test
    fun englishTest() {
        runScreenshotAutomation("en")
    }

    @Test
    fun germanTest() {
        runScreenshotAutomation("de")
    }

    @Test
    fun frenchTest() {
        runScreenshotAutomation("fr")
    }

    private fun restartActivity() {
        activityRule.scenario.onActivity {
            val intent = Intent(it.intent)
            it.finish()
            it.startActivity(intent)
        }
    }

    private fun checkAndChangeLanguage(language: String) {
        if (Locale.getDefault().displayLanguage != language) {
            val groups: MutableList<String> = ArrayList()
            groups.add("main")

            val languages: MutableList<String> = ArrayList()
            languages.add("en")
            languages.add("de")
            languages.add("fr")

            Applanga.update(groups, languages) {
                Applanga.setLanguage(language)
                restartActivity()
            }
        }
    }

    private fun runScreenshotAutomation(language: String) {

        checkAndChangeLanguage(language)
        SystemClock.sleep(2000)

        // Home page
        SystemClock.sleep(3000)
        Applanga.captureScreenshot("home", null)
        SystemClock.sleep(500)

        // Navigation drawer
        onView(withId(R.id.drawer_layout)).perform(DrawerActions.open())
        Applanga.captureScreenshot("navDrawer", null)
        SystemClock.sleep(500)

        // Daily weather page
        SystemClock.sleep(1000)
        onView(withId(R.id.nav_daily)).perform(click())
        Applanga.captureScreenshot("dailyWeather", null)
        SystemClock.sleep(500)

        // About page
        onView(withId(R.id.drawer_layout)).perform(DrawerActions.open())
        SystemClock.sleep(500)
        onView(withId(R.id.nav_about)).perform(click())
        SystemClock.sleep(1000)
        Applanga.captureScreenshot("about", null)
        SystemClock.sleep(500)

        // Settings page
        onView(withId(R.id.drawer_layout)).perform(DrawerActions.open())
        SystemClock.sleep(500)
        onView(withId(R.id.nav_settings)).perform(click())
        Applanga.captureScreenshot("settings", null)
        SystemClock.sleep(500)
    }

}