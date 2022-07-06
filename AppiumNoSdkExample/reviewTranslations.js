const wdio = require("webdriverio");
var client
const applanga = require("applanganosdkappiumtools");

var languagesToUse = ["de","es","en"]
var localesToUse = ["DE","ES","US"]
var buttonsToPress = ["Daily Forecast","About","Settings"]
var buttonsToPressAndroid = ["nav_daily","nav_about","nav_settings"]

const apiToken = "Bearer 62a356c8e75d020e19f519f2!1258dd115bd433c86f3f6959efb93b8a"
const appId = "62a356c8e75d020e19f519f2"

function getOptions(platform,locale,language)
{
    var androidOptions = {
        path: '/wd/hub',
        port: 4723,
        capabilities: {
          locale: locale,
          language: language,
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



async function main () {
   
   
    await reviewIosScreens()

    await reviewAndroidScreens()   
	
    await client.pause(4000)


}

async function reviewIosScreens()
{
	 //iOS Screens
    for (let i = 0; i < languagesToUse.length; i++) {
        const language = languagesToUse[i]
        const locale = localesToUse[i]
        client = await wdio.remote(getOptions("iOS",locale,language))
        await client.pause(2000)
        for (let i = 0; i < buttonsToPress.length; i++) {
            const btn = buttonsToPress[i] 
            await client.pause(8000)
            await pressButtons("iOS",buttonsToPress[i])
            await client.pause(2000)            
        }
        
    }
}

async function reviewAndroidScreens()
{
	 //Android Screens
   for (let i = 0; i < languagesToUse.length; i++) {
        const language = languagesToUse[i]
        const locale = localesToUse[i]
        client = await wdio.remote(getOptions("Android",locale,language))
        await client.pause(2000)
        for (let i = 0; i < buttonsToPressAndroid.length; i++) {
            const btn = buttonsToPressAndroid[i]       
            await client.pause(8000)
            await pressButtons("Android",btn)
            await client.pause(2000)            
        }
       
   }
}

async function pressButtons(platform,btnName)
{
    if(platform == "Android")
    {
        let selector = 'android=new UiSelector().resourceId(\"com.applanga.weathersample:id/' + btnName +'\")';
        let button = await client.$(selector);
        button.click()
        await client.pause(2000)
    }
    else
    {        
        let button = await client.$("~" + btnName);
        await button.click()
        await client.pause(2000) 
    }
}

main();
