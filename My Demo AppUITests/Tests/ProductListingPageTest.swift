import XCTest

class ProductListingPageTest: MyDemoAppTestBase {
    func testProductListingPageAddItemToCart() {
        PageObject().randonItem.tap()
        PageObject().addToCartButton.tap()
        PageObject().cartButton.tap()
        XCTAssert(app.staticTexts["1 Items"].exists)
    }
    
    func testProductListingPageAddMultipleItemsToCart() {
        PageObject().firstRandonItem.tap()
        PageObject().addToCartButton.tap()
        PageObject().catalogButton.tap()
        PageObject().secondRandonItem.tap()
        PageObject().addToCartButton.tap()
        PageObject().catalogButton.tap()
        PageObject().thirdRandonItem.tap()
        PageObject().addToCartButton.tap()
        PageObject().cartButton.tap()
        XCTAssert(PageObject().cartScreen.waitForExistence(timeout: 2))
        XCTAssert(app.staticTexts["3 Items"].exists)
    }
    
    func testProductListingPageDefault() throws {
        XCTAssert(PageObject().catalogScreen.exists)
        XCTAssert(PageObject().products.exists)
    }
}
