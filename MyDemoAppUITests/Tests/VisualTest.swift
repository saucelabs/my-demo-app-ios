import Foundation
import XCTest
import SauceVisual

/// Optional live example. Use the Sauce Visual Development scheme; keep MAD's Ad Hoc configuration unchanged.
final class VisualTest: MyDemoAppTestBase {
    private let productSelector = "Product Name"
    private let backpack = "Sauce Labs Backpack - Black"
    private var visual: VisualClient?

    private enum PreparationFailure: Error {
        case clientUnavailable
        case requiredElementMissing(String)
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        let environment = ProcessInfo.processInfo.environment
        let username = environment["SAUCE_USERNAME"]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let key = environment["SAUCE_ACCESS_KEY"]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        try XCTSkipIf(username.isEmpty || key.isEmpty, "Configure Sauce credentials to run this optional live example.")
        visual = try VisualClient(options: VisualBuildOptions(
            name: "XCUITest Sauce Visual demo", project: "xcuitest sauce demo",
            branch: environment["SAUCE_VISUAL_BRANCH"] ?? "feature/visual-xcui-demo",
            defaultBranch: environment["SAUCE_VISUAL_DEFAULT_BRANCH"] ?? "main",
            tags: ["My Demo App", "XCUITest Demo"]
        ))
    }

    override func tearDownWithError() throws {
        visual = nil
        try super.tearDownWithError()
        // Do not finish here: all tests in this process share the same run.
    }

    @MainActor
    private func require(_ element: XCUIElement, _ description: String, timeout: TimeInterval = 10) throws {
        try Task.checkCancellation()
        guard element.waitForExistence(timeout: timeout) else {
            throw PreparationFailure.requiredElementMissing(description)
        }
        try Task.checkCancellation()
    }

    @MainActor
    private var ignoredStatusBar: [XCUIElement] {
        let bar = XCUIApplication(bundleIdentifier: "com.apple.springboard").statusBars.firstMatch
        return bar.exists ? [bar] : []
    }

    @MainActor
    @discardableResult
    private func submit(_ name: String, options: VisualCheckOptions = VisualCheckOptions()) async throws -> VisualSnapshot {
        guard let visual else { throw PreparationFailure.clientUnavailable }
        let receipt = try await visual.sauceVisualCheck(name, options: options)
        XCTAssertNotNil(UUID(uuidString: receipt.id))
        XCTAssertGreaterThan(receipt.pixelWidth, 0)
        XCTAssertGreaterThan(receipt.pixelHeight, 0)
        if options.captureDom { XCTAssertTrue(receipt.hasDom, "Requested tree was uploaded") }
        // This asserts submission, not visual equality. Comparison status is evaluated separately.
        return receipt
    }

    @MainActor
    func testCatalogToCheckout() async throws {
        try require(PageObject().catalogScreen, "catalog")
        try await submit("Catalog", options: VisualCheckOptions(ignoreElements: ignoredStatusBar))

        let product = PageObject().selectItemByName(itemName: productSelector).firstMatch
        try require(product, "catalog product")
        product.tap()
        try require(PageObject().detailsPageOf(productName: backpack), "product details")
        try await submit("Product details", options: VisualCheckOptions(ignoreElements: ignoredStatusBar, captureDom: true))

        try require(PageObject().addToCartButton, "add to cart")
        PageObject().addToCartButton.tap()
        PageObject().cartButton.tap()
        try require(PageObject().cartDetailsPageOf(productName: backpack), "cart details")
        try await submit("Cart", options: VisualCheckOptions(ignoreElements: ignoredStatusBar, captureDom: true))

        let checkout = PageObject().cartScreen.buttons["ProceedToCheckout"]
        try require(checkout, "checkout")
        checkout.tap()
        try require(app.staticTexts["Select a username from the list below"], "login page")
        try await submit("Login", options: VisualCheckOptions(ignoreElements: ignoredStatusBar))

        let login = app.buttons["Login"].firstMatch
        try require(login, "login button")
        // A screenshot-only clip avoids depending on unsupported fractional DOM crop origins.
        try await submit("Login button", options: VisualCheckOptions(clipElement: login))
    }

    @MainActor
    func testCatalogBoundedScrollCapture() async throws {
        try require(PageObject().catalogScreen, "catalog")
        let list = PageObject().catalogScreen.collectionViews.firstMatch
        try require(list, "product list")
        let receipt = try await submit("Catalog - bounded scroll capture", options: VisualCheckOptions(
            // Explicitly allow an intentional prefix. Alignment or stability errors still fail.
            fullPage: FullPageScreenshot(scrollElement: list, scrollLimit: 15, allowPartialAtLimit: true)
        ))
        XCTAssertTrue(receipt.captureExtent == .noMovementDetected || receipt.captureExtent == .limitReached)
        XCTAssertFalse(receipt.hasDom, "Stitched-image DOM is not advertised as supported")
    }

    private var user: String {
        let enabled = ProcessInfo.processInfo.environment["VISUAL_CHECK"]?
            .trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "true"
        return enabled ? "visual@example.com" : "bob@example.com"
    }

    @MainActor
    func testCatalogAfterLogin() async throws {
        try require(PageObject().moreButton, "menu")
        PageObject().moreButton.tap()
        try require(PageObject().logOutButton, "logout")
        PageObject().logOutButton.tap()
        try require(app.staticTexts["Select a username from the list below"], "login page")
        try require(app.buttons[user], "selected example user")
        app.buttons[user].tap()
        app.buttons["Login"].firstMatch.tap()
        try require(PageObject().catalogScreen, "catalog after login")
        try await submit("Catalog - login", options: VisualCheckOptions(ignoreElements: ignoredStatusBar, captureDom: true))
    }
}
