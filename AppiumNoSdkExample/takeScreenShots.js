const wdio = require("webdriverio");
var client
const applanga = require("applanganosdkappiumtools");

var buttonsToPress = ["Daily Forecast", "About", "Settings"]
var buttonsToPressAndroid = ["nav_daily", "nav_about", "nav_settings"]

const apiToken = "Bearer 62a356c8e75d020e19f519f2!1258dd115bd433c86f3f6959efb93b8a"
const appId = "62a356c8e75d020e19f519f2"

function getOptions(platform, locale, language) {
    var androidOptions = {
        path: '/wd/hub',
        port: 4723,
        capabilities: {
            //   locale: locale,
            //   language: language,
            platformName: "Android",
            platformVersion: "11.0",
            deviceName: "Pixel_5_API_30",
            app: __dirname + "/Android/WeatherApp/app/build/outputs/apk/debug/app-debug.apk",
            appPackage: "com.applanga.weathersample",
            appActivity: "com.applanga.weathersample.MainActivity",
            automationName: "UiAutomator2"
        }
    };

    var iosOptions = {
        path: '/wd/hub',
        port: 4723,
        capabilities: {
            language: language,
            platformName: "iOS",
            platformVersion: "15.5",
            deviceName: "iPhone 12",
            app: __dirname + "/UIKit/WeatherSample/WeatherSample/Debug-iphonesimulator/WeatherSample.ipa",
            automationName: "XCUITest"
        }
    };
    return platform == "Android" ? androidOptions : iosOptions;
}



async function main() {


    await takeIosScreenshots()

    await takeAndroidScreenshots()

    await client.pause(4000)


}

async function takeIosScreenshots() {
    //iOS Screenshots
    const language = "en"
    const locale = "US"
    client = await wdio.remote(getOptions("iOS", locale, language))
    await applanga.captureScreenshot(client, "Home", "iOS", language, appId, apiToken)
    await client.pause(2000)
    for (let i = 0; i < buttonsToPress.length; i++) {
        const btn = buttonsToPress[i]
        if (btn == "About") {
            await client.pause(55000)

        } else {
            await client.pause(2000)

        }
        await pressButtons("iOS", buttonsToPress[i])
        await applanga.captureScreenshot(client, buttonsToPress[i], "iOS", language, appId, apiToken)
        await client.pause(3000)
    }


}

async function takeAndroidScreenshots() {
    //Android Screenshots
    const language = "en"
    const locale = "en-US"
    client = await wdio.remote(getOptions("Android", locale, language))
    await applanga.captureScreenshot(client, "Home", "Android", language, appId, apiToken)
    await client.pause(2000)
    for (let i = 0; i < buttonsToPressAndroid.length; i++) {
        const btn = buttonsToPressAndroid[i]
        await client.pause(5000)
        await pressButtons("Android", btn)
        await applanga.captureScreenshot(client, buttonsToPress[i], "Android", language, appId, apiToken)
        await client.pause(2000)
    }


}

async function pressButtons(platform, btnName) {
    if (platform == "Android") {
        let selector = 'android=new UiSelector().resourceId(\"com.applanga.weathersample:id/' + btnName + '\")';
        let button = await client.$(selector);
        button.click()
        await client.pause(2000)
    }
    else {
        let button = await client.$("~" + btnName);
        await button.click()
        await client.pause(2000)
    }
}

main();
