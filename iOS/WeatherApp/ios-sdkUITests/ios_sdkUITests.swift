//
//  ios_sdkUITests.swift
//  ios-sdkUITests
//

import XCTest
import Applanga

class ios_sdkUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        // allow screenshots
        app.launchArguments.append("ApplangaUITestScreenshotEnabled");
        app.launch()
    }
    
    func testExample0() {
        let hamburgerBtn = app.buttons["hamburgerBtn"]
        let dailyBtn = app.buttons["navDaily"]
        let aboutBtn = app.buttons["navAbout"]
        let settingsBtn = app.buttons["navSettings"]
        
        // home
        sleep(2)
        // ! take screenshot !
        //open screenshot menu by tapping invisible Applanga button
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.OpenScreenshotView"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.SelectTag"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.tables.staticTexts["Test"].tap();
        app.buttons["Applanga.ConfirmScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()

        //screenshot upload takes a while so we need to wait until the screenshot menu is visible again until we can proceed
        let predicate = NSPredicate(format: "exists == 1")
        let query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        // hide
        app.buttons["Applanga.CancelScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        
        sleep(2)
        print("Should take screenshot")
        // daily
        hamburgerBtn.tap()
        sleep(1)
        dailyBtn.tap()
        sleep(1)
        // ! take screenshot !
        
        // about
        hamburgerBtn.tap()
        sleep(1)
        aboutBtn.tap()
        sleep(3)
        // ! take screenshot !
        
        // settings
        hamburgerBtn.tap()
        sleep(1)
        settingsBtn.tap()
        sleep(1)
        // ! take screenshot !
        
        // nav
        hamburgerBtn.tap()
        sleep(1)
        // ! take screenshot !
        
        sleep(1)
    }

//    func testEnglish() {
//
//    }
//
//    func testGerman() {
//
//    }
//
//    func testFrench() {
//
//    }

}

func takeScreenshots(language: String) {
    checkAndChangeLanguage(language: language)
    
    
}

func checkAndChangeLanguage(language: String) {
    if (Locale.current.languageCode! != language) {
        Applanga.setLanguage(language)
    }
}

func captureScreenshot(app: XCUIApplication) {

}
