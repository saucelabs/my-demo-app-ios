import XCTest

class Navigation_UITests: MyDemoAppTestBase {
    func testNavigateToCart() throws {
        XCTAssert(PageObject().cart.exists)
        PageObject().cartEmptyButton.tap()
        XCTAssert(PageObject().cartEmpty.exists)
    }
            
    func testNavigateToMore() throws {
        XCTAssert(PageObject().moreButton.waitForExistence(timeout: 2))
        PageObject().moreSection.tap()
        XCTAssert(PageObject().webview.exists)
        XCTAssert(PageObject().qrCode.exists)
        XCTAssert(PageObject().geoLocation.exists)
        XCTAssert(PageObject().drawing.exists)
        XCTAssert(PageObject().about.exists)
        XCTAssert(PageObject().resetAppState.exists)
        XCTAssert(PageObject().faceID.exists)
    }
        
    func testNavigateMoreToWebview() throws {
        XCTAssert(PageObject().moreButton.waitForExistence(timeout: 2))
        PageObject().moreSection.tap()
        XCTAssert(PageObject().webview.waitForExistence(timeout: 2))
    }
    
    func testNavigateMoreToAbout() throws {
        XCTAssert(PageObject().moreButton.waitForExistence(timeout: 2))
        PageObject().moreSection.tap()
        XCTAssert(PageObject().about.waitForExistence(timeout: 2))
        PageObject().aboutButton.tap()
        XCTAssert(PageObject().about.exists)
    }
    
    func testNavigateMoreToQRCode() throws {
        XCTAssert(PageObject().moreButton.waitForExistence(timeout: 2))
        PageObject().moreSection.tap()
        XCTAssert(PageObject().qrCode.waitForExistence(timeout: 2))
        PageObject().QRCodeButton.tap()
        XCTAssert(PageObject().qrCode.exists)
    }
    
    func testNavigateMoreToGeoLocation() throws {
        XCTAssert(PageObject().moreButton.waitForExistence(timeout: 2))
        PageObject().moreSection.tap()
        XCTAssert(PageObject().geoLocation.exists)
        PageObject().geoLocationButton.tap()
        XCTAssert(PageObject().geoLocation.exists)
    }
    
    func testNavigateMoreToDrawing() throws {
        XCTAssert(PageObject().moreButton.waitForExistence(timeout: 2))
        PageObject().moreSection.tap()
        XCTAssert(PageObject().drawing.exists)
        PageObject().drawingButton.tap()
        XCTAssert(PageObject().drawing.exists)
    }
            
    func testNavigateFromCartToCatalog() throws {
        XCTAssert(PageObject().cart.waitForExistence(timeout: 2))
        PageObject().cartEmptyButton.tap()
        XCTAssert(PageObject().goShoppingButton.waitForExistence(timeout: 2))
    }
            
    func testNavigateCartToCatalog() throws {
        XCTAssert(PageObject().cart.waitForExistence(timeout: 2))
        PageObject().cartEmptyButton.tap()
        XCTAssert(PageObject().goShoppingButton.waitForExistence(timeout: 2))
        PageObject().goShoppingSection.tap()
        XCTAssert(PageObject().catalog.waitForExistence(timeout: 2))
    }
}
