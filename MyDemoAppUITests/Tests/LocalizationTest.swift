import XCTest

class LocalizationTest: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        app = XCUIApplication()
        let device = XCUIDevice.shared
        // start always in portrait mode
        device.orientation = .portrait
    }

    func testLocalization() throws {
        // Make sure the app always starts in English
        app.launchArguments = [
            "-AppleLanguages",
            "(en)",
            "-AppleLocale",
            "en_US"
        ]
        app.launch()
        // Now Validate that we are in English
        XCTAssert(app.staticTexts["Sauce Labs Backpack - Black"].exists)

        // Change the language by:
        // 1.Terminating the App
        app.terminate()
        // 2. Removing the language args from the launchArgs. Because we added them
        //    in the MyDemoAppTestBase as the last two we can remove them here.
        app.launchArguments = []
        // 3. Add two new launch args that would set the language to German
        app.launchArguments = [
            "-AppleLanguages",
            "(de)",
            "-AppleLocale",
            "de_DE"
        ]

        // 4. Launch the app
        app.launch()

        // Check the German text
        app.swipeUp()
        app.swipeUp()
        XCTAssert(app.staticTexts["Sauce Labs Rucksack - Black"].exists)

    }

    override func tearDown() {
        super.tearDown()
        app.terminate()
    }
}
