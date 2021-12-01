
import XCTest

public class PageObject {
    let app = XCUIApplication()
    lazy var about = app.staticTexts["About"]
    lazy var aboutButton = app.windows.children(matching: .other)
                        .containing(.staticText, identifier: "About")
                        .firstMatch
    lazy var addButton = app.scrollViews.otherElements.buttons["Add To Cart"]
    
    lazy var averageRateButton = app.scrollViews.otherElements.containing(.staticText, identifier:"Sauce Lab Back Packs")
                            .children(matching: .other).element(boundBy: 1)
    
    lazy var cart = app.staticTexts["Cart"]
    lazy var cartButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other)
                        .element.children(matching: .other).element.children(matching: .other)
                        .element.children(matching: .other).element.children(matching: .other)
                        .element.children(matching: .other).element.children(matching: .other)
                        .element.children(matching: .other).element(boundBy: 3)
                        .children(matching: .other).element.children(matching: .other)
                        .element(boundBy: 1).children(matching: .button).element
    lazy var cartEmpty = app.staticTexts["No Items"]
    lazy var cartEmptyButton = app.windows.children(matching: .other)
                            .containing(.staticText, identifier: "Cart")
                            .firstMatch
    lazy var catalog = app.staticTexts["Catalog"]
    lazy var catalogButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other)
                        .element.children(matching: .other).element.children(matching: .other).element.children(matching: .other)
                        .element.children(matching: .other).element.children(matching: .other).element.children(matching: .other)
                        .element.children(matching: .other).element(boundBy: 3).children(matching: .other).element.children(matching: .other)
                        .element(boundBy: 0).children(matching: .button).element
    lazy var changeColor = app.scrollViews.otherElements.buttons["BlueColorUnSelected Icons"]
    
    lazy var defaultColor = app.scrollViews.otherElements.buttons["RedColorUnSelected Icons"]
    lazy var drawing = app.staticTexts["Drawing"]
    lazy var drawingButton = app.windows.children(matching: .other)
                            .containing(.staticText, identifier: "Drawing")
                            .firstMatch
    
    lazy var faceID = app.staticTexts["FaceID"]
    lazy var finalProductsValue = app.staticTexts["2"]
    lazy var firstProduct = app.staticTexts["Sauce Lab Back Packs"]
    lazy var firstRandonItem = app.collectionViews.children(matching: .cell)
                            .element(boundBy: 2).children(matching: .other)
                            .element.children(matching: .other).element
    
    lazy var geoLocation = app.staticTexts["Geo Location"]
    lazy var geoLocationButton = app.windows.children(matching: .other)
                            .containing(.staticText, identifier: "Geo Location")
                            .firstMatch
    lazy var goShoppingButton = app.staticTexts["Go Shopping"]
    lazy var goShoppingSection = app.windows.children(matching: .other)
                            .containing(.staticText, identifier: "Go Shopping")
                            .firstMatch
    
    lazy var infoTitle = app.staticTexts["Product Highlights"]
    lazy var initialColor = app.scrollViews.otherElements.buttons["RedColorUnSelected Icons"]
    lazy var initialValue = app.staticTexts["1"]
    
    lazy var loginSection = app.staticTexts["Login"]
    
    lazy var moreButton = app.staticTexts["More"]
    lazy var moreSection = app.windows.children(matching: .other)
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
    
    lazy var price = app.staticTexts["$ 29.99"]
    lazy var proceedToCheckoutButton = app.staticTexts["Proceed To Checkout"]
    lazy var products = app.staticTexts["Products"]
    
    lazy var qrCode = app.staticTexts["QR Code Scanner"]
    lazy var QRCodeButton = app.windows.children(matching: .other)
                        .containing(.staticText, identifier: "QR Code Scanner")
                        .firstMatch
    
    lazy var randonItem = app.collectionViews.children(matching: .cell).element(boundBy: 1)
                        .children(matching: .other).element
                        .children(matching: .other).element
    lazy var rateValue = app.scrollViews.otherElements.buttons["StarSelected Icons"]
    lazy var resetAppState = app.staticTexts["Reset App State"]
    
    lazy var secondRandonItem = app.collectionViews.children(matching: .cell).element(boundBy: 1)
                                .children(matching: .other).element
                                .children(matching: .other).element
    lazy var substractButton = app.scrollViews.otherElements.buttons["SubtractMinus Icons"]
    
    lazy var thirdRandonItem = app.collectionViews.children(matching: .cell).element(boundBy: 3).children(matching: .other)
                            .element.children(matching: .other)
                            .element
    
    lazy var webview = app.staticTexts["Webview"]
    
    lazy var zeroValue = app.staticTexts["0"]
}
