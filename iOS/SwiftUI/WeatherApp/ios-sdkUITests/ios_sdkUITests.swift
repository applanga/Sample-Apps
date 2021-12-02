//
//  ios_sdkUITests.swift
//  ios-sdkUITests
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

class ios_sdkUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        // allow screenshots
        app.launchArguments.append("ApplangaUITestScreenshotEnabled");
        app.launchArguments.append("ApplangaShowIdModeEnabled");
        app.launch()
    }
    
    func testScreenshots() {
        runAutomatedScreenshots()
    }
    
    func takeScrenshots(tag: String) {
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
    
    func runAutomatedScreenshots() {
        let hamburgerBtn = app.buttons["hamburgerBtn"]
        let homeBtn = app.buttons["navHome"]
        let dailyBtn = app.buttons["navDaily"]
        let aboutBtn = app.buttons["navAbout"]
        let settingsBtn = app.buttons["navSettings"]
        
        // Home screen
        hamburgerBtn.tap()
        sleep(1)
        homeBtn.tap()
        sleep(1)
        takeScrenshots(tag: "Home")

        // Daily screen
        hamburgerBtn.tap()
        sleep(1)
        dailyBtn.tap()
        sleep(1)
        takeScrenshots(tag: "Daily")

        //  About screen
        hamburgerBtn.tap()
        sleep(1)
        aboutBtn.tap()
        sleep(3)
        takeScrenshots(tag: "About")
        
        // Settings screen
        hamburgerBtn.tap()
        sleep(1)
        settingsBtn.tap()
        sleep(1)
        takeScrenshots(tag: "Settings")
    }
    
}


