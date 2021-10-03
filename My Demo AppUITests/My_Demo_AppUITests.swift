import XCTest

class My_Demo_AppUITests: MyDemoAppTestBase {

    func testAddItemToCart() {
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Add To Cart"]/*[[".buttons[\"Add To Cart\"].staticTexts[\"Add To Cart\"]",".staticTexts[\"Add To Cart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        
        XCTAssert(app.staticTexts["1 Items"].exists)
        
    }
    
    func testAddMultipleItems() {
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.tap()
        
        let addToCartStaticText = app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Add To Cart"]/*[[".buttons[\"Add To Cart\"].staticTexts[\"Add To Cart\"]",".staticTexts[\"Add To Cart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        addToCartStaticText.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .other).element
        let button = element.children(matching: .other).element(boundBy: 0).children(matching: .button).element
        button.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        addToCartStaticText.tap()
        button.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element.tap()
        addToCartStaticText.tap()
        element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        
        XCTAssert(app.staticTexts["3 Items"].exists)
    }
    
    func testProductDefaultHomePage() throws {
        let catalog = app.staticTexts["Catalog"]
        let products = app.staticTexts["Products"]
        
        XCTAssert(catalog.exists)
        XCTAssert(products.exists)
    }
            
    func testProductDetails() throws {
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        firstProduct.tap()
        
        XCTAssert(firstProduct.exists)
    }
        
    func testProductDetailsPrice() throws {
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        let price = app.staticTexts["$ 29.99"]
        firstProduct.tap()
        
        XCTAssert(firstProduct.exists)
        XCTAssert(price.exists)
    }
        
    func testProductDetailsHighlights() throws {
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        let infoTitle = app.staticTexts["Product Highlights"]
        firstProduct.tap()
        
        XCTAssert(firstProduct.exists)
        XCTAssert(infoTitle.exists)
    }
        
    func testProductDetailsDecreaseNumberOfItems() throws {
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        let zeroValue = app.staticTexts["0"]
        let substractButton = app.scrollViews.otherElements.buttons["SubtractMinus Icons"]

        firstProduct.tap()
        substractButton.tap()

        XCTAssert(firstProduct.exists)
        XCTAssert(zeroValue.exists)
    }
        
        
    func testProductDetailsIncreaseNumberOfItems() throws {
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        let addButton = app.scrollViews.otherElements.buttons["Add To Cart"]
        let initialValue = app.staticTexts["1"]
        let finalProductsValue = app.staticTexts["2"]
        firstProduct.tap()
        
        XCTAssert(initialValue.exists)
        
        addButton.tap()
        addButton.tap()
        
        XCTAssert(finalProductsValue.exists)
    }
        
    func testProductDetailsDefaultColor() throws {
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        let defaultColor = app.scrollViews.otherElements.buttons["RedColorUnSelected Icons"]
        firstProduct.tap()
        
        XCTAssert(defaultColor.exists)
        XCTAssert(defaultColor.isSelected)
    }
        
    func testProductDetailsColorsSwitch() throws {
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        let initialColor = app.scrollViews.otherElements.buttons["RedColorUnSelected Icons"]
        let changeColor = app.scrollViews.otherElements.buttons["BlueColorUnSelected Icons"]
        firstProduct.tap()
        
        XCTAssert(firstProduct.exists)
        XCTAssert(initialColor.isSelected)
        XCTAssertEqual(false, changeColor.isSelected)
        
        changeColor.tap()
        
        XCTAssert(changeColor.isSelected)
        XCTAssertEqual(false, initialColor.isSelected)
    }
        
    func testProductDetailsRatesSelection() throws {
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        let rateValue = app.scrollViews.otherElements.buttons["StarSelected Icons"]
        let averageRateButton = app.scrollViews.otherElements.containing(.staticText, identifier:"Sauce Lab Back Packs")
                                    .children(matching: .other).element(boundBy: 1)
        firstProduct.tap()
        
        XCTAssert(rateValue.exists)
        
        averageRateButton.tap()
        
        XCTAssert(rateValue.exists)
    }
        
    func testNavigateToCart() throws {
        let cartButton = app.staticTexts["Cart"]
        let cartEmpty = app.staticTexts["No Items"]
        XCTAssert(cartButton.exists)
        
        app.windows.children(matching: .other)
            .containing(.staticText, identifier: "Cart")
            .firstMatch
            .tap()

        XCTAssert(cartEmpty.exists)
    }
            
    func testNavigateToMore() throws {
        let moreButton = app.staticTexts["More"]
        let webview = app.staticTexts["Webview"]
        let qrCode = app.staticTexts["QR Code Scanner"]
        let geoLocation = app.staticTexts["Geo Location"]
        let drawing = app.staticTexts["Drawing"]
        let about = app.staticTexts["About"]
        let resetAppState = app.staticTexts["Reset App State"]
        let faceID = app.staticTexts["FaceID"]
        
        XCTAssert(moreButton.waitForExistence(timeout: 2))
        
        app.windows.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element(boundBy: 4).children(matching: .other)
            .element.children(matching: .other)
            .element(boundBy: 2).children(matching: .button)
            .element.tap()
        
        XCTAssert(webview.exists)
        XCTAssert(qrCode.exists)
        XCTAssert(geoLocation.exists)
        XCTAssert(drawing.exists)
        XCTAssert(about.exists)
        XCTAssert(resetAppState.exists)
        XCTAssert(faceID.exists)

    }
        
    func testNavigateMoreToWebview() throws {
        let moreButton = app.staticTexts["More"]
        let webview = app.staticTexts["Webview"]
        
        XCTAssert(moreButton.waitForExistence(timeout: 2))
        
        app.windows.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element.children(matching: .other)
            .element(boundBy: 4).children(matching: .other)
            .element.children(matching: .other)
            .element(boundBy: 2).children(matching: .button)
            .element.tap()
        
        XCTAssert(webview.exists)
    }
            
    func testNavigateFromCartToCatalog() throws {
        let catalog = app.staticTexts["Catalog"]
        let cartButton = app.staticTexts["Cart"]
        let goShoppingButton = app.staticTexts["Go Shopping"]
        
        XCTAssert(cartButton.waitForExistence(timeout: 2))
        
        app.windows.children(matching: .other)
            .containing(.staticText, identifier: "Cart")
            .firstMatch
            .tap()
        
        XCTAssert(goShoppingButton.waitForExistence(timeout: 2))
        
        app.windows.children(matching: .other)
            .containing(.staticText, identifier: "Go Shopping")
            .firstMatch
            .tap()
        
        XCTAssert(catalog.waitForExistence(timeout: 2))
    }
            
    func testNavigateCartToCatalog() throws {
        let catalog = app.staticTexts["Catalog"]
        let cartButton = app.staticTexts["Cart"]
        let goShoppingButton = app.staticTexts["Go Shopping"]
        
        XCTAssert(cartButton.waitForExistence(timeout: 2))
        
        app.windows.children(matching: .other)
            .containing(.staticText, identifier: "Cart")
            .firstMatch
            .tap()
        
        XCTAssert(goShoppingButton.waitForExistence(timeout: 2))
        
        app.windows.children(matching: .other)
            .containing(.staticText, identifier: "Go Shopping")
            .firstMatch
            .tap()
        
        XCTAssert(catalog.waitForExistence(timeout: 2))
    }
        
    func testAddToCart() throws {
        let addToCartButton = app.scrollViews.otherElements.buttons["Add To Cart"]
        let cartButton = app.windows.children(matching: .other)
                            .containing(.staticText, identifier: "Cart")
                            .firstMatch
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        
        firstProduct.tap()
        addToCartButton.tap()
        cartButton.tap()

        XCTAssert(firstProduct.exists)
    }
        
    func testProceedToCheckout() throws {
        let addToCartButton = app.scrollViews.otherElements.buttons["Add To Cart"]
        let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
        
        firstProduct.tap()
        addToCartButton.tap()
        //TODO: fix checkout button
//        let button = app.collectionViews.children(matching: .cell)
//            .element(boundBy: 0).children(matching: .other)
//            .element.children(matching: .other)
//            .firstMatch
        
//        button.tap()
//        XCTAssert(firstProduct.exists)
//        let proceedToCheckoutStaticText = app.staticTexts["Proceed To Checkout"]
//        XCTAssert(proceedToCheckoutStaticText.waitForExistence(timeout: 5))
//        proceedToCheckoutStaticText.tap()
    }
}
