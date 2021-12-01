import XCTest

class ProductDetailsTest: MyDemoAppTestBase {
    func testProductDetails() throws {
        PageObject().firstProduct.tap()
        XCTAssert(PageObject().firstProduct.exists)
    }
        
    func testProductDetailsPrice() throws {
        PageObject().firstProduct.tap()
        XCTAssert(PageObject().firstProduct.exists)
        XCTAssert(PageObject().price.exists)
    }
        
    func testProductDetailsHighlights() throws {
        PageObject().firstProduct.tap()
        XCTAssert(PageObject().firstProduct.exists)
        XCTAssert(PageObject().infoTitle.exists)
    }
        
    func testProductDetailsDecreaseNumberOfItems() throws {
        PageObject().firstProduct.tap()
        PageObject().substractButton.tap()
        XCTAssert(PageObject().firstProduct.exists)
        XCTAssert(PageObject().zeroValue.exists)
    }
        
        
    func testProductDetailsIncreaseNumberOfItems() throws {
        PageObject().firstProduct.tap()
        XCTAssert(PageObject().initialValue.exists)
        PageObject().addButton.tap()
        PageObject().addButton.tap()
        XCTAssert(PageObject().finalProductsValue.exists)
    }
        
    func testProductDetailsDefaultColor() throws {
        PageObject().firstProduct.tap()
        XCTAssert(PageObject().defaultColor.exists)
        XCTAssert(PageObject().defaultColor.isSelected)
    }
        
    func testProductDetailsColorsSwitch() throws {
        PageObject().firstProduct.tap()
        XCTAssert(PageObject().firstProduct.exists)
        XCTAssert(PageObject().defaultColor.isSelected)
        XCTAssertEqual(false, PageObject().changeColor.isSelected)
        PageObject().changeColor.tap()
        XCTAssert(PageObject().changeColor.isSelected)
        XCTAssertEqual(false, PageObject().initialColor.isSelected)
    }
        
    func testProductDetailsRatesSelection() throws {
        PageObject().firstProduct.tap()
        XCTAssert(PageObject().rateValue.exists)
        PageObject().averageRateButton.tap()
        XCTAssert(PageObject().rateValue.exists)
    }
    
    func testProductDetailsAddToCart() throws {
        PageObject().firstProduct.tap()
        PageObject().addButton.tap()
        PageObject().cartButton.tap()
        XCTAssert(PageObject().firstProduct.exists)
    }
        
    func testProductDetailsProceedToCheckout() throws {
        PageObject().firstProduct.tap()
        PageObject().addButton.tap()
        PageObject().cartButton.tap()
        PageObject().proceedToCheckoutButton.tap()
        XCTAssert(PageObject().loginSection.exists)
    }
}
