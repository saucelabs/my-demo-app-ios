import XCTest

class ProductListingPage_UITests: MyDemoAppTestBase {

    func testProductListingPageAddItemToCart() {
        PageObject().randonItem.tap()
        PageObject().addButton.tap()
        PageObject().cartButton.tap()
        XCTAssert(app.staticTexts["1 Items"].exists)
    }
    
    func testProductListingPageAddMultipleItemsToCart() {
        PageObject().firstRandonItem.tap()
        PageObject().addButton.tap()
        PageObject().catalogButton.tap()
        PageObject().secondRandonItem.tap()
        PageObject().addButton.tap()
        PageObject().catalogButton.tap()
        PageObject().thirdRandonItem.tap()
        PageObject().addButton.tap()
        PageObject().cartButton.tap()
        XCTAssert(app.staticTexts["3 Items"].exists)
    }
    
    func testProductListingPageDefault() throws {
        XCTAssert(PageObject().catalog.exists)
        XCTAssert(PageObject().products.exists)
    }
}
