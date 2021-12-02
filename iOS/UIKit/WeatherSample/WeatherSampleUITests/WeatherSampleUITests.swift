//
//  WeatherSampleUITests.swift
//  WeatherSampleUITests
//

import XCTest

extension XCUIElement {
    func tapOnPosition() {
        coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
    }
}

class AutomatedScreenshotsTest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launchArguments.append("ApplangaUITestScreenshotEnabled")
        app.launch()
    }

    func testSreenshots() {
        app.launch()
        
        sleep(1)
        changeAppLanguage(lang: "en")
        takeAllScreenshots()
        
        changeAppLanguage(lang: "de")
        takeAllScreenshots()
        
        changeAppLanguage(lang: "fr")
        takeAllScreenshots()
    }
    
    func takeScreenshot(tag: String) {
        //open screenshot menu by tapping invisible Applanga button
        app.buttons["Applanga.ToggleDraftMenu"].tapOnPosition()
        app.buttons["Applanga.OpenScreenshotView"].tapOnPosition()
        app.buttons["Applanga.SelectTag"].tapOnPosition()
        
        // this line fails if you haven't add you tag to
        // the applanga dashboard yet
        // -> add the tag once on the dashboard and then run the test
        app.tables.staticTexts["\(tag)"].tap();
        app.buttons["Applanga.ConfirmScreenshot"].tapOnPosition()
        
        // screenshot upload takes a while so we need to wait until the screenshot menu is visible again until we can proceed
        let predicate = NSPredicate(format: "exists == 1")
        let query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        // close the draft menu
        app.buttons["Applanga.CancelScreenshot"].tapOnPosition()
        app.buttons["Applanga.ToggleDraftMenu"].tapOnPosition()
        sleep(1)
    }
    
    func takeAllScreenshots() {
        
        // Home
        app.tabBars.buttons.element(boundBy: 0).tap();
        sleep(1)
        takeScreenshot(tag: "Home")

        // Daily forecast
        app.tabBars.buttons.element(boundBy: 1).tap();
        sleep(1)
        takeScreenshot(tag: "Daily")

        // About
        app.tabBars.buttons.element(boundBy: 2).tap();
        sleep(1)
        takeScreenshot(tag: "About")

        // Settings
        app.tabBars.buttons.element(boundBy: 3).tap();
        sleep(1)
        takeScreenshot(tag: "Settings")
        
        sleep(1)
    }
    
    func changeAppLanguage(lang: String) {
        // Settings
        app.tabBars.buttons.element(boundBy: 3).tap();
        app.buttons["\(lang)"].tap()
        sleep(2)
        app.buttons["save"].tap()
        sleep(2)
    }
}
