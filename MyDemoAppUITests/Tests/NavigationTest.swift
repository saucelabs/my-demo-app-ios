import XCTest

class NavigationTest: MyDemoAppTestBase {
    func testNavigateToCart() throws {
        PageObject().cartButton.tap()
        XCTAssert(PageObject().cartEmpty.exists)
    }
            
    func testNavigateToMore() throws {
        PageObject().moreButton.tap()
        XCTAssert(PageObject().webviewButton.exists)
        XCTAssert(PageObject().qrCodeScannerButton.exists)
        XCTAssert(PageObject().geoLocationButton.exists)
        XCTAssert(PageObject().drawingButton.exists)
        XCTAssert(PageObject().aboutButton.exists)
        XCTAssert(PageObject().resetAppStateButton.exists)
        XCTAssert(PageObject().biometricsButton.exists)
    }
        
    func testNavigateMoreToWebview() throws {
        PageObject().moreButton.tap()
        PageObject().webviewButton.tap()
        XCTAssert(PageObject().webviewScreen.waitForExistence(timeout: 2))
    }
    
    func testNavigateMoreToAbout() throws {
        PageObject().moreButton.tap()
        PageObject().aboutButton.tap()
        XCTAssert(PageObject().aboutScreen.waitForExistence(timeout: 2))
    }
    
    func testNavigateMoreToQRCode() throws {
        PageObject().moreButton.tap()
        PageObject().qrCodeScannerButton.tap()
        XCTAssert(PageObject().qrCodeScannerScreen.waitForExistence(timeout: 2))
    }
    
    func testNavigateMoreToGeoLocation() throws {
        PageObject().moreButton.tap()
        PageObject().geoLocationButton.tap()
        XCTAssert(PageObject().geoLocaltionScreen.waitForExistence(timeout: 2))
    }
    
    func testNavigateMoreToDrawing() throws {
        PageObject().moreButton.tap()
        PageObject().drawingButton.tap()
        XCTAssert(PageObject().drawingScreen.waitForExistence(timeout: 2))
    }
            
    func testNavigateFromCartToCatalog() throws {
        PageObject().cartButton.tap()
        XCTAssert(PageObject().cartScreen.waitForExistence(timeout: 2))
    }
            
    func testNavigateCartToCatalog() throws {
        PageObject().cartButton.tap()
        PageObject().goShoppingButton.tap()
        XCTAssert(PageObject().catalogScreen.waitForExistence(timeout: 2))
    }
}
