import XCTest
import SauceVisual

// Sauce Visual demo. Requires SAUCE_USERNAME and SAUCE_ACCESS_KEY in the
// scheme's Test environment variables; the tests are skipped without them.
class VisualTest: MyDemoAppTestBase {
    let productSelector = "Product Name"
    let backPack = "Sauce Labs Backpack - Black"

    var visual: VisualClient!

    // Snapshots on `branch` are compared with the baselines of `defaultBranch`.
    override func setUpWithError() throws {
        try super.setUpWithError()
        let environment = ProcessInfo.processInfo.environment
        try XCTSkipIf((environment["SAUCE_USERNAME"] ?? "").isEmpty || (environment["SAUCE_ACCESS_KEY"] ?? "").isEmpty,
                      "Set SAUCE_USERNAME and SAUCE_ACCESS_KEY to run the Sauce Visual demo")
        visual = try VisualClient(options: VisualBuildOptions(
            name: "Xcuitest Sauce Visual demo",
            project: "xcuitest sauce demo",
            branch: "feature/visual-xcui-demo",
            defaultBranch: "main",
            tags: ["My Demo App", "XCUItest Demo"]
        ))
    }

    // The status bar clock changes on every run, so leave it out of the comparison.
    // The status bar belongs to SpringBoard, not the app, and its height depends on the device.
    @MainActor
    var statusBar: XCUIElement { XCUIApplication(bundleIdentifier: "com.apple.springboard").statusBars.firstMatch }

    @MainActor
    func testCatalogToCheckout() async throws {
        // Catalog
        XCTAssert(PageObject().catalogScreen.waitForExistence(timeout: 2))
        try await visual.sauceVisualCheck("Catalog", options: VisualCheckOptions(
            ignoreElements: [statusBar]
        ))

        // Product details, with the element tree so the dashboard shows which element changed
        PageObject().selectItemByName(itemName: productSelector).firstMatch.tap()
        XCTAssert(PageObject().detailsPageOf(productName: backPack).waitForExistence(timeout: 2))
        try await visual.sauceVisualCheck("Product details", options: VisualCheckOptions(
            ignoreElements: [statusBar],
            captureDom: true
        ))

        // Add to cart, then open the cart
        PageObject().addToCartButton.tap()
        PageObject().cartButton.tap()
        XCTAssert(PageObject().cartDetailsPageOf(productName: backPack).waitForExistence(timeout: 2))
        try await visual.sauceVisualCheck("Cart", options: VisualCheckOptions(
            ignoreElements: [statusBar],
            captureDom: true
        ))

        // Checkout without logging in opens the Login page
        PageObject().cartScreen.buttons["ProceedToCheckout"].tap()
        XCTAssert(app.staticTexts["Select a username from the list below"].waitForExistence(timeout: 2))
        try await visual.sauceVisualCheck("Login", options: VisualCheckOptions(
            ignoreElements: [statusBar]
        ))

        // Snapshot only the Login button, with its element tree
        let loginButton = app.buttons["Login"].firstMatch
        XCTAssert(loginButton.exists)
        try await visual.sauceVisualCheck("Login button", options: VisualCheckOptions(
            clipElement: loginButton,
            captureDom: true
        ))
    }

    // Full-page screenshot: scrolls the product list and stitches every product into one image.
    @MainActor
    func testCatalogFullPage() async throws {
        XCTAssert(PageObject().catalogScreen.waitForExistence(timeout: 2))
        let productList = PageObject().catalogScreen.collectionViews.firstMatch
        XCTAssert(productList.exists)

        try await visual.sauceVisualCheck("Catalog - full page", options: VisualCheckOptions(
            fullPage: FullPageScreenshot(scrollElement: productList, scrollLimit: 15)
        ))
    }

    // Run without VISUAL_CHECK and approve the snapshot as the baseline, then run with
    // VISUAL_CHECK=true to log in as visual@example.com and see a diff: for that user
    // the app gives products random prices, swaps two product images and centres the title.
    var user: String {
        (ProcessInfo.processInfo.environment["VISUAL_CHECK"] ?? "").isEmpty ? "bob@example.com" : "visual@example.com"
    }

    @MainActor
    func testCatalogAfterLogin() async throws {
        PageObject().moreButton.tap()
        PageObject().logOutButton.tap()
        XCTAssert(app.staticTexts["Select a username from the list below"].waitForExistence(timeout: 2))
        app.buttons[user].tap()
        app.buttons["Login"].firstMatch.tap()
        XCTAssert(PageObject().catalogScreen.waitForExistence(timeout: 2))

        try await visual.sauceVisualCheck("Catalog - login", options: VisualCheckOptions(
            ignoreElements: [statusBar],
            captureDom: true
        ))
    }
}
