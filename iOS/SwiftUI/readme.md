# Applanga Demo - SwiftUI Weather App

A sample app that demnstrates Applanga's localization SDK automatic string upload, as well as automated screenshot uploads.

## Installation

 * Create an account on [Applanga](https://dashboard.applanga.com/#!/login).
 * Create a new project with English as the base language.
 * In the project overview page, click on the "Prepare Release" button. 
 * Click the "Get Settings File" button and download the Settings File
 * Open ```/Sample-Apps/iOS/SwiftUI/WeatherApp/weatherApp.xcworkspace```, and add the Settings File to the project. Make sure to mark both project and UI tests as targets.
 * In a new terminal session, open ```/Sample-Apps/iOS/SwiftUI/WeatherApp``` and run the command "run install".
 * From Xcode, run the app.
   * After the app has started wait for about 10 seconds. At this point all base language strings should have been uploaded to the Applanga dashboard.
 * On the dashboard, pick English from the project languages. You should now see all uploaded strings.

## Automated UI Tests

 * Add German (language code DE) and French (language code FR) to your app on the Applanga dashboard
 * Go into German and import **Localizable_de.xliff**. Switch Language to French and import **Localizable_fr.xliff**.
 * On the dashboard, open the "Tags" sidebar and create four new tags with the following names: 'Home', 'Daily', 'About' and 'Settings'.
 * In Xcode open ```weatherAppUITests```. Run the tests.
    * You should now see the test running, capturing and uploading screenshots of the app in all languages (English, German, French).
 * In the dashboard, in the language view, open the "Screens" window on the left of the language view. Screenshots should now appear for each language along with their tags.
