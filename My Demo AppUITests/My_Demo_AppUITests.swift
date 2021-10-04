import XCTest

let about = app.staticTexts["About"]
let aboutButton = app.windows.children(matching: .other)
                    .containing(.staticText, identifier: "About")
                    .firstMatch
let addButton = app.scrollViews.otherElements.buttons["Add To Cart"]

let app = XCUIApplication()
let averageRateButton = app.scrollViews.otherElements.containing(.staticText, identifier:"Sauce Lab Back Packs")
                        .children(matching: .other).element(boundBy: 1)

let cart = app.staticTexts["Cart"]
let cartButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other)
                    .element.children(matching: .other).element.children(matching: .other)
                    .element.children(matching: .other).element.children(matching: .other)
                    .element.children(matching: .other).element.children(matching: .other)
                    .element.children(matching: .other).element(boundBy: 3)
                    .children(matching: .other).element.children(matching: .other)
                    .element(boundBy: 1).children(matching: .button).element
let cartEmpty = app.staticTexts["No Items"]
let cartEmptyButton = app.windows.children(matching: .other)
                        .containing(.staticText, identifier: "Cart")
                        .firstMatch
let catalog = app.staticTexts["Catalog"]
let catalogButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other)
                    .element.children(matching: .other).element.children(matching: .other).element.children(matching: .other)
                    .element.children(matching: .other).element.children(matching: .other).element.children(matching: .other)
                    .element.children(matching: .other).element(boundBy: 3).children(matching: .other).element.children(matching: .other)
                    .element(boundBy: 0).children(matching: .button).element
let changeColor = app.scrollViews.otherElements.buttons["BlueColorUnSelected Icons"]

let defaultColor = app.scrollViews.otherElements.buttons["RedColorUnSelected Icons"]
let drawing = app.staticTexts["Drawing"]
let drawingButton = app.windows.children(matching: .other)
                        .containing(.staticText, identifier: "Drawing")
                        .firstMatch

let faceID = app.staticTexts["FaceID"]
let finalProductsValue = app.staticTexts["2"]
let firstProduct = app.staticTexts["Sauce Lab Back Packs"]
let firstRandonItem = app.collectionViews.children(matching: .cell)
                        .element(boundBy: 2).children(matching: .other)
                        .element.children(matching: .other).element

let geoLocation = app.staticTexts["Geo Location"]
let geoLocationButton = app.windows.children(matching: .other)
                        .containing(.staticText, identifier: "Geo Location")
                        .firstMatch
let goShoppingButton = app.staticTexts["Go Shopping"]
let goShoppingSection = app.windows.children(matching: .other)
                        .containing(.staticText, identifier: "Go Shopping")
                        .firstMatch

let infoTitle = app.staticTexts["Product Highlights"]
let initialColor = app.scrollViews.otherElements.buttons["RedColorUnSelected Icons"]
let initialValue = app.staticTexts["1"]

let loginSection = app.staticTexts["Login"]

let moreButton = app.staticTexts["More"]
let moreSection = app.windows.children(matching: .other)
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
                    .element

let price = app.staticTexts["$ 29.99"]
let proceedToCheckoutButton = app.staticTexts["Proceed To Checkout"]
let products = app.staticTexts["Products"]

let qrCode = app.staticTexts["QR Code Scanner"]
let QRCodeButton = app.windows.children(matching: .other)
                    .containing(.staticText, identifier: "QR Code Scanner")
                    .firstMatch

let randonItem = app.collectionViews.children(matching: .cell).element(boundBy: 1)
                    .children(matching: .other).element
                    .children(matching: .other).element
let rateValue = app.scrollViews.otherElements.buttons["StarSelected Icons"]
let resetAppState = app.staticTexts["Reset App State"]

let secondRandonItem = app.collectionViews.children(matching: .cell).element(boundBy: 1)
                            .children(matching: .other).element
                            .children(matching: .other).element
let substractButton = app.scrollViews.otherElements.buttons["SubtractMinus Icons"]

let thirdRandonItem = app.collectionViews.children(matching: .cell).element(boundBy: 3).children(matching: .other)
                        .element.children(matching: .other)
                        .element

let webview = app.staticTexts["Webview"]

let zeroValue = app.staticTexts["0"]



class My_Demo_AppUITests: MyDemoAppTestBase {

    func testProductListingPageAddItemToCart() {
        randonItem.tap()
        addButton.tap()
        cartButton.tap()
        XCTAssert(app.staticTexts["1 Items"].exists)
    }
    
    func testProductListingPageAddMultipleItemsToCart() {
        firstRandonItem.tap()
        addButton.tap()
        catalogButton.tap()
        secondRandonItem.tap()
        addButton.tap()
        catalogButton.tap()
        thirdRandonItem.tap()
        addButton.tap()
        cartButton.tap()
        XCTAssert(app.staticTexts["3 Items"].exists)
    }
    
    func testProductListingPageDefault() throws {
        XCTAssert(catalog.exists)
        XCTAssert(products.exists)
    }
            
    func testProductDetails() throws {
        firstProduct.tap()
        XCTAssert(firstProduct.exists)
    }
        
    func testProductDetailsPrice() throws {
        firstProduct.tap()
        XCTAssert(firstProduct.exists)
        XCTAssert(price.exists)
    }
        
    func testProductDetailsHighlights() throws {
        firstProduct.tap()
        XCTAssert(firstProduct.exists)
        XCTAssert(infoTitle.exists)
    }
        
    func testProductDetailsDecreaseNumberOfItems() throws {
        firstProduct.tap()
        substractButton.tap()
        XCTAssert(firstProduct.exists)
        XCTAssert(zeroValue.exists)
    }
        
        
    func testProductDetailsIncreaseNumberOfItems() throws {
        firstProduct.tap()
        XCTAssert(initialValue.exists)
        addButton.tap()
        addButton.tap()
        XCTAssert(finalProductsValue.exists)
    }
        
    func testProductDetailsDefaultColor() throws {
        firstProduct.tap()
        XCTAssert(defaultColor.exists)
        XCTAssert(defaultColor.isSelected)
    }
        
    func testProductDetailsColorsSwitch() throws {
        firstProduct.tap()
        XCTAssert(firstProduct.exists)
        XCTAssert(defaultColor.isSelected)
        XCTAssertEqual(false, changeColor.isSelected)
        changeColor.tap()
        XCTAssert(changeColor.isSelected)
        XCTAssertEqual(false, initialColor.isSelected)
    }
        
    func testProductDetailsRatesSelection() throws {
        firstProduct.tap()
        XCTAssert(rateValue.exists)
        averageRateButton.tap()
        XCTAssert(rateValue.exists)
    }
    
    func testProductDetailsAddToCart() throws {
        firstProduct.tap()
        addButton.tap()
        cartButton.tap()
        XCTAssert(firstProduct.exists)
    }
        
    func testProductDetailsProceedToCheckout() throws {
        firstProduct.tap()
        addButton.tap()
        cartButton.tap()
        proceedToCheckoutButton.tap()
        XCTAssert(loginSection.exists)
    }
        
    func testNavigateToCart() throws {
        XCTAssert(cart.exists)
        cartEmptyButton.tap()
        XCTAssert(cartEmpty.exists)
    }
            
    func testNavigateToMore() throws {
        XCTAssert(moreButton.waitForExistence(timeout: 2))
        moreSection.tap()
        XCTAssert(webview.exists)
        XCTAssert(qrCode.exists)
        XCTAssert(geoLocation.exists)
        XCTAssert(drawing.exists)
        XCTAssert(about.exists)
        XCTAssert(resetAppState.exists)
        XCTAssert(faceID.exists)
    }
        
    func testNavigateMoreToWebview() throws {
        XCTAssert(moreButton.waitForExistence(timeout: 2))
        moreSection.tap()
        XCTAssert(webview.exists)
    }
    
    func testNavigateMoreToAbout() throws {
        XCTAssert(moreButton.waitForExistence(timeout: 2))
        moreSection.tap()
        XCTAssert(about.exists)
        aboutButton.tap()
        XCTAssert(about.exists)
    }
    
    func testNavigateMoreToQRCode() throws {
        XCTAssert(moreButton.waitForExistence(timeout: 2))
        moreSection.tap()
        XCTAssert(qrCode.exists)
        QRCodeButton.tap()
        XCTAssert(qrCode.exists)
    }
    
    func testNavigateMoreToGeoLocation() throws {
        XCTAssert(moreButton.waitForExistence(timeout: 2))
        moreSection.tap()
        XCTAssert(geoLocation.exists)
        geoLocationButton.tap()
        XCTAssert(geoLocation.exists)
    }
    
    func testNavigateMoreToDrawing() throws {
        XCTAssert(moreButton.waitForExistence(timeout: 2))
        moreSection.tap()
        XCTAssert(drawing.exists)
        drawingButton.tap()
        XCTAssert(drawing.exists)
    }
            
    func testNavigateFromCartToCatalog() throws {
        XCTAssert(cart.waitForExistence(timeout: 2))
        cartEmptyButton.tap()
        XCTAssert(goShoppingButton.waitForExistence(timeout: 2))
    }
            
    func testNavigateCartToCatalog() throws {
        XCTAssert(cart.waitForExistence(timeout: 2))
        cartEmptyButton.tap()
        XCTAssert(goShoppingButton.waitForExistence(timeout: 2))
        goShoppingSection.tap()
        XCTAssert(catalog.waitForExistence(timeout: 2))
    }
}
