//
//  WeatherSampleUITests.swift
//  WeatherSampleUITests
//

import XCTest

class AutomatedScreenshotsTest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        app.launchArguments.append("ApplangaUITestScreenshotEnabled");
        app.launch()
    }

    func testExample() {
        takeScreenshot(tag: "Home")
    }
    
    func takeScreenshot(tag: String) {
        //open screenshot menu by tapping invisible Applanga button
        app.buttons["Applanga.ToggleDraftMenu"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.OpenScreenshotView"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.buttons["Applanga.SelectTag"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        app.tables.staticTexts["\(tag)"].tap();
        app.buttons["Applanga.ConfirmScreenshot"].coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()

        //screenshot upload takes a while so we need to wait until the screenshot menu is visible again until we can proceed
        let predicate = NSPredicate(format: "exists == 1")
        let query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
    }
}
