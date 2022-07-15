const wdio = require("webdriverio");
var client
const applanga = require("applanganosdkappiumtools");
const fs = require('fs');

var buttonsToPressAndroid = ["nav_daily", "nav_about", "nav_settings"]


function getOptions(locale,language) {
    var androidOptions = {
        path: '/wd/hub',
        port: 4723,
        capabilities: {
            locale: locale,
            language: language,
            platformName: "Android",
            udid: "emulator-5554",
            app: __dirname + "/WeatherApp/app/build/outputs/apk/debug/app-debug.apk",
            appPackage: "com.applanga.weathersample",
            appActivity: "com.applanga.weathersample.MainActivity",
            automationName: "UiAutomator2"
        }
    };


    return androidOptions;
}



async function main() {

    let apiToken = readAPIToken()

    let appId = findAppId(apiToken)

    await takeAndroidScreenshots(apiToken, appId)

    await client.pause(4000)


}

function readAPIToken() {
    let rawdata = fs.readFileSync('.applanga.json');
    let applanga = JSON.parse(rawdata);
    let app = applanga.app;
    let token = app.access_token

    let bearer = "Bearer" + " " ;

    let accssTkn = bearer.concat(token);

    return accssTkn

}

function findAppId(str) {

    var subString = str.substr(0 , 24);
    
    return subString

}


async function takeAndroidScreenshots(apiToken, appId) {
    //Android Screenshots
    const language = "de"
    const locale = "DE"
    client = await wdio.remote(getOptions(locale, language))
    await applanga.captureScreenshot(client, "Home", "Android", language, appId, apiToken)
    await client.pause(2000)
    for (let i = 0; i < buttonsToPressAndroid.length; i++) {
        const btn = buttonsToPressAndroid[i]
        await client.pause(5000)
        await pressButtons(btn)
        await applanga.captureScreenshot(client, btn, "Android", language, appId, apiToken)
        await client.pause(2000)
    }


}

async function pressButtons(btnName) {

    let selector = 'android=new UiSelector().resourceId(\"com.applanga.weathersample:id/' + btnName + '\")';
    let button = await client.$(selector);
    button.click()
    await client.pause(2000)

}

main();
