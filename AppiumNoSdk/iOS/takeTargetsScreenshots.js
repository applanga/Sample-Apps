const wdio = require("webdriverio");
var client
const applanga = require("applanganosdkappiumtools");
const fs = require('fs');

var languagesToUse = ["de", "es"]
var localesToUse = ["DE", "US"]
var buttonsToPress = ["Daily Forecast", "About", "Settings"]


function getOptions(language) {

    var iosOptions = {
        path: '/wd/hub',
        port: 4723,
        capabilities: {
            language: language,
            platformName: "iOS",
            platformVersion: "15.5",
            deviceName: "iPhone 12",
            app: __dirname + "/WeatherSample/WeatherSample/Debug-iphonesimulator/WeatherSample.ipa",
            automationName: "XCUITest"
        }
    };
    return iosOptions;
}



async function main() {

    let apiToken = readAPIToken()

    let appId = findAppId(apiToken)

    await takeIosTargetsScreenshots(apiToken, appId)


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

async function takeIosTargetsScreenshots(apiToken, appId) {
    //iOS Screens
    for (let i = 0; i < languagesToUse.length; i++) {
        const language = languagesToUse[i]
        const locale = localesToUse[i]
        client = await wdio.remote(getOptions(language))
        await applanga.captureScreenshot(client, "Home", "iOS", language, appId, apiToken)
        await client.pause(2000)
        for (let i = 0; i < buttonsToPress.length; i++) {
            const btn = buttonsToPress[i]
            if (btn == "About") {
                await client.pause(55000)
    
            } else {
                await client.pause(2000)
    
            }
            await pressButtons(btn)
            await applanga.captureScreenshot(client, btn, "iOS", language, appId, apiToken)
            await client.pause(3000)
        }
    }
}



async function pressButtons(btnName) {

    let button = await client.$("~" + btnName);
    await button.click()
    await client.pause(2000)

}

main();
