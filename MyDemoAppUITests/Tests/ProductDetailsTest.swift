import XCTest

class ProductDetailsTest: MyDemoAppTestBase {
    let productSelector = "Product Name"
    let backPack = "Sauce Labs Backpack - Black"

    func testProductDetails() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        XCTAssert(PageObject().detailsPageOf(productName: backPack).exists)
    }
        
    func testProductDetailsPrice() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        XCTAssert(PageObject().getPrice(price: "$ 29.99").exists)
    }

    func testProductDetailsHighlights() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        XCTAssert(PageObject().infoTitle.exists)
    }

    func testProductDetailsDecreaseNumberOfItems() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        PageObject().substractAmountButton.tap()
        XCTAssert(PageObject().productAmount(amount: "0").exists)
    }


    func testProductDetailsIncreaseNumberOfItems() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        XCTAssert(PageObject().productAmount(amount: "1").exists)
        PageObject().addAmountButton.tap()
        PageObject().addAmountButton.tap()
        XCTAssert(PageObject().productAmount(amount: "3").exists)
    }

    func testProductDetailsDefaultColor() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        XCTAssert(PageObject().getColor(color: "Green").exists)
        XCTAssert(PageObject().getColor(color: "Green").isSelected)
    }

    func testProductDetailsColorsSwitch() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        XCTAssert(PageObject().getColor(color: "Green").isSelected)
        XCTAssertEqual(false, PageObject().getColor(color: "Blue").isSelected)
        PageObject().getColor(color: "Blue").tap()
        XCTAssert(PageObject().getColor(color: "Blue").isSelected)

    }

    func testProductDetailsRatesSelection() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        XCTAssert(PageObject().rateValue.exists)
        PageObject().averageRateButton.tap()
        XCTAssert(PageObject().rateValue.exists)
    }

    func testProductDetailsAddToCart() throws {
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        PageObject().addToCartButton.tap()
        PageObject().cartButton.tap()
        XCTAssert(PageObject().cartDetailsPageOf(productName: backPack).exists)
    }
}
