//
//  WeatherSampleUITests.swift
//  WeatherSampleUITests
//

import XCTest

extension XCUIApplication {
    func copyApplangaIdsAndPositionsToClipboard(){
        var idsAndPosDict: [String: String] = [:]
        let desc = self.debugDescription;
        func matchAndAdd(pattern: String){
            let regex = try! NSRegularExpression(pattern: pattern);
            let matches = regex.matches(in: desc,
                                        range: NSRange(desc.startIndex..., in: desc));
            for(match) in matches{
                guard let posRange = Range(match.range(at: 2), in: desc) else {
                    continue
                }
                guard let labelRange = Range(match.range(at: 3), in: desc) else {
                    continue
                }
                let pos = String(desc[posRange]);
                let label = String(desc[labelRange]);
                idsAndPosDict[label] = pos;
            }
        }
        matchAndAdd(pattern: "StaticText,(\\s|[0-9]|x|[a-f])+,\\s(\\{\\{.*\\}\\}),\\slabel:\\s\\'(.*)\\'")
        matchAndAdd(pattern: "Button,(\\s|[0-9]|x|[a-f])+,\\s(\\{\\{.*\\}\\}).*label:\\s\\'([^']*)")
        var idsAndPosString = "";
        if let json = try? JSONEncoder().encode(idsAndPosDict) {
            idsAndPosString = String(data: json, encoding: .utf8)!
        }
        let pasteBoard = UIPasteboard.general
        idsAndPosString = "applanga:" + idsAndPosString
        pasteBoard.string = idsAndPosString;
    }

}

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
        app.launchArguments.append("ApplangaShowIdModeEnabled")
        app.launch()
    }

    func testScreenshotsShowId() {
        sleep(1)
        takeScreenshot(tag: "Home")

        sleep(1)
        // Daily
        takeScreenshot(tag: "Daily Screen")
        // changing screen
        app.buttons["About"].tap()

        sleep(1)
        // About
        takeScreenshot(tag: "About Screen")
        // changing screen
        app.buttons["Settings"].tap()

        sleep(1)
        // Settings
        takeScreenshot(tag: "Settings Screen")
        
        app.terminate()
    }

    func testSreenshots() {
        app.launchArguments.remove(at: 1)
        app.launch()
        
        sleep(1)

        // change language to English
        app.buttons["Settings"].tap()
        sleep(1)
        changeAppLanguage(lang: "en")
        sleep(2)
        
        takeScreenshotsForLang(home: "Home", daily: "Daily Forecast", about: "About", settings: "Settings")
        

        sleep(1)
        changeAppLanguage(lang: "de")
        sleep(2)

        takeScreenshotsForLang(home: "Startseite", daily: "Tägliche Prognose", about: "Über", settings: "Einstellungen")

        sleep(1)
        changeAppLanguage(lang: "fr")
        sleep(2)
        
        takeScreenshotsForLang(home: "Domicile", daily: "Prévisions quotidiennes", about: "Environ", settings: "Paramètres")

        sleep(1)

    }
    
    func takeScreenshot(tag: String) {
        //open screenshot menu by tapping invisible Applanga button
        app.buttons["Applanga.ToggleDraftMenu"].tapOnPosition()
        app.buttons["Applanga.OpenScreenshotView"].tapOnPosition()
        app.buttons["Applanga.SelectTag"].tapOnPosition()
        app.tables.staticTexts["\(tag)"].tap();
        app.copyApplangaIdsAndPositionsToClipboard();
        app.buttons["Applanga.ConfirmScreenshot"].tapOnPosition()
        
        //screenshot upload takes a while so we need to wait until the screenshot menu is visible again until we can proceed
        let predicate = NSPredicate(format: "exists == 1")
        let query = XCUIApplication().buttons["Applanga.SelectTag"];
        expectation(for: predicate, evaluatedWith: query, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        //Close the draft menu
        app.buttons["Applanga.CancelScreenshot"].tapOnPosition()
        app.buttons["Applanga.ToggleDraftMenu"].tapOnPosition()
        sleep(1)
    }
    
    func takeScreenshotsForLang(home: String, daily: String, about: String, settings: String) {
        
        app.buttons["\(home)"].tap()
        sleep(1)
        takeScreenshot(tag: "Home")

        app.buttons["\(daily)"].tap()
        sleep(1)
        takeScreenshot(tag: "Daily")

        app.buttons["\(about)"].tap()
        sleep(1)
        takeScreenshot(tag: "About")

        app.buttons["\(settings)"].tap()
        sleep(1)
        takeScreenshot(tag: "Settings")
        
        sleep(1)
    }
    
    func changeAppLanguage(lang: String) {
        app.buttons["\(lang)"].tap()
        sleep(2)
        app.buttons["save"].tap()
    }
}
