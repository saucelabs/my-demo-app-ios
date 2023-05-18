import XCTest
import Foundation

class MyDemoAppTestBase: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        app.launch()
    }
    
    func enter( _ text: String, in textField: String) {
        let field = app.textFields[textField]
        waitForElementToAppear(field)
        field.tap()
        field.typeText(text)
    }
    
    func assertValueIn(_ staticText: String, equals value: String?) {
        let label = app.staticTexts[staticText]
        waitForElementToAppear(label)
        XCTAssertEqual(value, label.label)
    }
    
    func takeScreenshot(_  named: String = "myScreenShot") {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = named
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func waitForElementToAppear(_ element: XCUIElement){
        let result = element.waitForExistence(timeout: 5)
        guard result else {
            XCTFail("Element does not appear")
            return
        }
    }
    
    override func tearDown() {
        super.tearDown()
        app.terminate()
    }
}

