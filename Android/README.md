# Applanga Demo - Android Weather App

A sample app that demnstrates Applanga's localization SDK automatic string upload, as well as automated screenshot uploads.

## Installation

 * Create an account on [Applanga](https://dashboard.applanga.com/#!/login).
 * Create a new project with English as the base language.
 * In the project overview page, click on the "Prepare Release" button. 
 * Click the "Get Settings File" button, download the Settings File and place it in the ```~/WeatherApp/app/src/main/res/raw``` directory of the project in Android Studio.
 * Click the 🐞 button to start the app in Debug Mode.
   * You can do this with either a real device connected to your computer or launch the app on a virtual device
   * After the app has started wait for about 10 seconds. At this point all base language strings should have been uploaded to the Applanga dashboard.
 * On the dashboard, pick English from the project languages. You should now see all uploaded strings.

## Automated UI Tests

 * Add German (language code DE) and French (language code FR) to your app on the Applanga dashboard
 * Go into German and import [Weather-App_strings_de.xliff](https://github.com/applanga/Sample-Apps/blob/android-app/Android/Weather-App_strings_de.xliff). Switch Language to French and import [Weather-App_strings_fr.xliff](https://github.com/applanga/Sample-Apps/blob/android-app/Android/Weather-App_strings_fr.xliff).
 * in Android Studio right click to ```app->java->...->ExampleInstrumentedTest and click Run ExampleInstrumentedTest```
    * You should now see the test running, capturing and uploading screenshots of the app in all languages (English, German, French).
 * In the dashboard, in the language view, open the "Tags" window on the left of the language view. Screenshots should now appear for each language together with their tags.
* Open a screenshot, and click on the *variants* tab. When choosing an OS, note how you can switch between your device and the **show ID mode** version of that device. in this mode, string ID's are shown instead of they're values. This is useful to capture strings that were set at runtime.