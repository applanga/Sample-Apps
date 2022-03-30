# Weather App
## Applanga Flutter Sample App

This is a sample application to showcase the usage of applanga_flutter. It includes over-the-air updates (OTA) for android and iOS.
You also can use `applanga_flutter` without OTA updates for all platforms. For more information refer to the [applanga_flutter documentation]('https://github.com/applanga/applanga_flutter').

## Run this sample
To be able to run this sample application you have connect your applanga project with the flutter project.
Read the steps below to make it work.

### Updating API Token
Add your API Token to the bottom of your `pubspec.yaml`
```yaml
applanga_flutter:
  access_token: xxxxxxxxxxxxxxxx
```
You can get your API Token on the on the dashboard from your `project settings`. The token is needed for pulling and pushing new translations.

### Dashboard Preparation
For this sample app there are 3 languages already created for the project. In order to run the sample app for the first time you will need to go to your [Applanga Dashboard](https://dashboard.applanga.com) and add `English`, `German` and `French`. Once these have been added you will then need to run the following command `flutter pub run applanga_flutter:push --force`. This will then push all the default translations for the sample app to your dashboard. 

### Adding the settings file
Navigate to your [Applanga Dashboard](https://dashboard.applanga.com). Once there simply click on `Prepare Release` and once the page loads select `Get Settings File`. Then go back to your project and add the Applanga settings file to your Android modules resources `res/raw` directory. Also Add the Applanga Settings File to your iOS modules main target. To do this open the iOS module in Xcode and drag the settings file into the project. Make sure to `tick the target` you want it applied to. 

### Adding New Strings
To add new strings to your project you will need to add them to the base language `.arb` file. For example the base language for this project is english `lib/l10n/app_en.arb`. Once you have added the new string to the .arb file, you will need to run the following command `flutter pub run applanga_flutter:generate`. This will then generate your new strings in the `ApplangaLocalizations` file.    

### Adding a New Language
To add a new language to your project you will have to go to your [Applanga Dashboard](https://dashboard.applanga.com). In your project you will then see the `All Languages` list where you can simply click `add` to add new languages to your project. Once this has been added you can add your machine translations for your new language. You can then use the `Pull and Push` applanga_flutter commands to pull the new translations to your project. 

Before using the push and pull commands you will need to ensure you have set up [Applanga CLI](https://www.applanga.com/docs/integration-documentation/cli) first. Then you can run the below commands:

Execute `flutter pub run applanga_flutter:pull` from your shell and the package will download all new strings from all languages and add them to the corresponding arb files.

Execute `flutter pub run applanga_flutter:push` from your shell and the package will upload all newly added strings from the arb files to the applanga dashboard.

By default your base language `.arb` file is the single source of truth. So a `pull` will get and save all translations for all languages except the base language into corresponding arb files. A `push` will update only strings from the base language which are not uploaded yet to the dashboard.
With this configuration a `flutter pub run applanga_flutter:push --force` is recommended. All translations for the base language and its meta-data (important for icu strings) are uploaded and updated.You can change that `push` and `pull` behavior in your `.applanga.json`.

### Running Integration Tests
When running the integration tests you can run this by navigating to your terminal and running the following command `flutter drive --driver=integration_test/test_driver/integration_test_driver.dart --target=integration_test/screenshot_test.dart`. The current integration test runs through the application and takes screenshots of each page and then uploads these to your Applanga project. 
