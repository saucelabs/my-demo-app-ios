
import XCTest

public class PageObject {
    let app = XCUIApplication()
//    lazy var about = app.staticTexts["About"]
//    lazy var aboutButton = app.windows.children(matching: .other)
//                        .containing(.staticText, identifier: "About")
//                        .firstMatch
    
    lazy var averageRateButton = app.scrollViews.otherElements.containing(.staticText, identifier:"Sauce Lab Back Packs")
                            .children(matching: .other).element(boundBy: 1)
    
    lazy var cartButton = app.buttons["Cart-tab-item"]
//    lazy var cartButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other)
//                        .element.children(matching: .other).element.children(matching: .other)
//                        .element.children(matching: .other).element.children(matching: .other)
//                        .element.children(matching: .other).element.children(matching: .other)
//                        .element.children(matching: .other).element(boundBy: 3)
//                        .children(matching: .other).element.children(matching: .other)
//                        .element(boundBy: 1).children(matching: .button).element
    lazy var cartEmpty = app.staticTexts["No Items"]
//    lazy var cartEmptyButton = app.windows.children(matching: .other)
//                            .containing(.staticText, identifier: "Cart")
//                            .firstMatch

    lazy var catalogButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other)
                        .element.children(matching: .other).element.children(matching: .other).element.children(matching: .other)
                        .element.children(matching: .other).element.children(matching: .other).element.children(matching: .other)
                        .element.children(matching: .other).element(boundBy: 3).children(matching: .other).element.children(matching: .other)
                        .element(boundBy: 0).children(matching: .button).element
    lazy var changeColor = app.scrollViews.otherElements.buttons["BlueColorUnSelected Icons"]
    
    lazy var defaultColor = app.scrollViews.otherElements.buttons["RedColorUnSelected Icons"]
//    lazy var drawingButton = app.windows.children(matching: .other)
//                            .containing(.staticText, identifier: "Drawing")
//                            .firstMatch
    
    lazy var faceID = app.staticTexts["FaceID"]
    lazy var finalProductsValue = app.staticTexts["2"]
    lazy var firstProduct = app.staticTexts["Sauce Lab Back Packs"]
    lazy var firstRandonItem = app.collectionViews.children(matching: .cell)
                            .element(boundBy: 2).children(matching: .other)
                            .element.children(matching: .other).element
    

    lazy var goShoppingSection = app.windows.children(matching: .other)
                            .containing(.staticText, identifier: "Go Shopping")
                            .firstMatch
    
    lazy var infoTitle = app.staticTexts["Product Highlights"]
    lazy var initialColor = app.scrollViews.otherElements.buttons["RedColorUnSelected Icons"]
    lazy var initialValue = app.staticTexts["1"]
    
    lazy var loginSection = app.staticTexts["Login"]
    
    lazy var moreButton = app.buttons["More-tab-item"]
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
    
    lazy var zeroValue = app.staticTexts["0"]
    
    // Menu items
    lazy var webviewButton = app.buttons["Webview-menu-item"]
    lazy var qrCodeScannerButton = app.buttons["QrCodeScanner-menu-item"]
    lazy var geoLocationButton = app.buttons["GeoLocation-menu-item"]
    lazy var drawingButton = app.buttons["Drawing-menu-item"]
    lazy var aboutButton = app.buttons["About-menu-item"]
    lazy var resetAppStateButton = app.buttons["ResetAppState-menu-item"]
    lazy var biometricsButton = app.buttons["Biometrics-menu-item"]
    lazy var logOutButton = app.buttons["LogOut-menu-item"]
    
    // Screens
    lazy var webviewScreen = app.otherElements["Webview-screen"]
    lazy var qrCodeScannerScreen = app.otherElements["QrCodeScanner-screen"]
    lazy var geoLocaltionScreen = app.otherElements["GeoLocation-screen"]
    lazy var drawingScreen = app.otherElements["Drawing-screen"]
    lazy var aboutScreen = app.otherElements["About-screen"]
    lazy var resetAppScreen = app.otherElements["ResetAppState-screen"]
    lazy var biometricsScreen = app.otherElements["Biometrics-screen"]
    lazy var logOutScreen = app.otherElements["LogOut-screen"]
    
    
    // Cart
    lazy var cartScreen = app.otherElements["Cart-screen"]
    lazy var goShoppingButton = app.buttons["GoShopping"]
    
    // Catalog
    lazy var catalogScreen = app.otherElements["Catalog-screen"]
    
    // Product Details
    lazy var productDetailsScreen = app.otherElements["ProductDetails-screen"]
    lazy var addToCartButton = app.buttons["Add To Cart"]
}
