//
//  ios_sdkUITests.swift
//  ios-sdkUITests
//
//  Created by Yoav Ben Zvi on 23.03.21.
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
        
        // daily
        hamburgerBtn.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0)).tap()
//        hamburgerBtn.tap()
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

//    func testExample1() {
//        Applanga.setLanguage("en") // not working
//        Applanga.setScreenShotMenuVisible(true) // not working
//        app.terminate()
//        app.launch()
//    }
    
//    func testExample2() {
//        let app = XCUIApplication();
//
//        //open screenshot menu by tapping invisible Applanga button
//        app.buttons["Applanga.ToggleScreenShotMenu"].tap();
//        app.buttons["Applanga.SelectTag"].tap();
//        app.tables.staticTexts["Main"].tap();
//        app.buttons["Applanga.CaptureScreen"].tap();
//
//        //screenshot upload takes a while so we need to wait until the screenshot menu is visible again until we can proceed
//        let predicate = NSPredicate(format: "exists == 1")
//        let query = XCUIApplication().buttons["Applanga.SelectTag"];
//        expectation(for: predicate, evaluatedWith: query, handler: nil)
//        waitForExpectations(timeout: 3, handler: nil)
//    }
    
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
