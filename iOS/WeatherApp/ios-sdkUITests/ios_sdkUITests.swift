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
    
    func testExample() {
        let hamburgerBtn = app.buttons["hamburgerBtn"]
        let dailyBtn = app.buttons["navDaily"]
        let aboutBtn = app.buttons["navAbout"]
        let settingsBtn = app.buttons["navSettings"]
        
        sleep(2)
        
        // home
        // take screenshot
        // open screenshot menu by tapping invisible Applanga button
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.OpenScreenshotView"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.SelectTag"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        // select tag from tag list
        app.tables.staticTexts["Home"].tap();
        app.buttons["Applanga.ConfirmScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()

        // screenshot upload takes a while so we need to wait until the screenshot menu is visible again until we can proceed
        var predicate = NSPredicate(format: "exists == 1")
        var query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        // hide screenshot menu
        app.buttons["Applanga.CancelScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        
        // daily
        hamburgerBtn.tap()
        sleep(1)
        dailyBtn.tap()
        sleep(1)
        // take screenshot
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.OpenScreenshotView"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.SelectTag"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.tables.staticTexts["Daily"].tap();
        app.buttons["Applanga.ConfirmScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()

        predicate = NSPredicate(format: "exists == 1")
        query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        app.buttons["Applanga.CancelScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        
        // about
        hamburgerBtn.tap()
        sleep(1)
        aboutBtn.tap()
        sleep(3)
        // take screenshot
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.OpenScreenshotView"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.SelectTag"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.tables.staticTexts["About"].tap();
        app.buttons["Applanga.ConfirmScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()

        predicate = NSPredicate(format: "exists == 1")
        query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        app.buttons["Applanga.CancelScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        
        // settings
        hamburgerBtn.tap()
        sleep(1)
        settingsBtn.tap()
        sleep(1)
        // take screenshot
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.OpenScreenshotView"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.SelectTag"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.tables.staticTexts["Settings"].tap();
        app.buttons["Applanga.ConfirmScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()

        predicate = NSPredicate(format: "exists == 1")
        query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        app.buttons["Applanga.CancelScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        
        // nav
        hamburgerBtn.tap()
        sleep(1)
        // take screenshot
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.OpenScreenshotView"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.SelectTag"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.tables.staticTexts["Navigation"].tap();
        app.buttons["Applanga.ConfirmScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()

        predicate = NSPredicate(format: "exists == 1")
        query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        app.buttons["Applanga.CancelScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        
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

func checkAndChangeLanguage(language: String) {
    if (Locale.current.languageCode! != language) {
        // go to settings and change language
    }
}
