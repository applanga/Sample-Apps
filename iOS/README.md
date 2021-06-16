# Applanga Demo - IOS Weather App

A sample app that demnstrates Applanga's localization SDK automatic string upload, as well as automated screenshot uploads.

## Installation

 * Create an account on [Applanga](https://dashboard.applanga.com/#!/login).
 * Create a new project with English as the base language.
 * In the project overview page, click on the "Prepare Release" button. 
 * Click the "Get Settings File" button, download the Settings File and place it in the ```~/WeatherSample/WeatherSample``` directory of the project.
 * Open a new terminal session at ```~/WeatherSample``` and run the command 'pod install'.
 * Run the app
 * Perform a two-finger click anywhere on the screen for 6-8 seconds. an overlay menu should appear.
 * Copy the **draft mode key** from the project overview page on the dashboard, paste it and click the "Enable" button. 
 * Run the app again. It is now in Draft Mode.
 * After the app has started wait for about 10 seconds. At this point all base language strings should have been uploaded to the Applanga dashboard.
 * On the dashboard, pick English from the project languages. You should now see all uploaded strings.

## Automated UI Tests

 * Add German (language code DE) and French (language code FR) to your app's languages on the Applanga dashboard
 * Go into German and import [ios_strings_de.xliff](https://github.com/applanga/Sample-Apps/blob/android-app/Android/Weather-App_strings_de.xliff). Switch Language to French and import [ios_strings_fr.xliff](https://github.com/applanga/Sample-Apps/blob/android-app/Android/Weather-App_strings_fr.xliff).
 * In Xcode, open ```WeatherSampleUITests/WeatherSampleUITests.swift``` and and run the "AutomatedScreenshotsTest" test suite.
 * You should now see the test running, capturing and uploading screenshots of the app in all languages (English, German, French).
 * In the dashboard, in the language view, open the "Screens" window on the left of the language view. Screenshots should now appear for each language together with their tags.
