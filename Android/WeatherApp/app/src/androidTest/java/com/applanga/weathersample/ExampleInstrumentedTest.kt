package com.applanga.weathersample

import android.content.Intent
import android.os.SystemClock
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
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

        val dateIds = listOf(
            "days_sunday",
            "days_monday",
            "days_tuesday",
            "days_wednesday",
            "days_thursday",
            "days_friday",
            "days_saturday",
            "month_january",
            "month_february",
            "month_march",
            "month_april",
            "month_may",
            "month_june",
            "month_july",
            "month_august",
            "month_september",
            "month_october",
            "month_november",
            "month_december",
        )

        // Home page
        SystemClock.sleep(3000)
        Applanga.captureScreenshot("Home", null)
        SystemClock.sleep(500)

        // Daily weather page
        SystemClock.sleep(1000)
        onView(withId(R.id.nav_daily)).perform(click())
        SystemClock.sleep(1000)
        Applanga.captureScreenshot("DailyWeather", null)
        SystemClock.sleep(500)

        // About page
        // we need to pass the string id's as this is a webview
        val aboutIds = listOf(
            "about_app_header",
            "about_app_text",
            "about_features_header",
            "about_features_text_first",
            "about_features_text_second",
            "about_display_header",
            "about_display_text",
            "about_settings_header",
            "about_settings_text")
        SystemClock.sleep(1000)
        onView(withId(R.id.nav_about)).perform(click())
        SystemClock.sleep(1000)
        Applanga.captureScreenshot("About", aboutIds)
        SystemClock.sleep(500)

        // Settings page
        SystemClock.sleep(1000)
        onView(withId(R.id.nav_settings)).perform(click())
        SystemClock.sleep(1000)
        Applanga.captureScreenshot("Settings", null)
        SystemClock.sleep(500)
    }

}