import XCTest

class LoginTest: MyDemoAppTestBase {

    // Credentials come from process environment variables, which saucectl populates
    // per-suite from `env:` in full-config.yml. This only reaches the test process
    // when the suite targets `simulators:` (Sauce's VMD backend) - it's a no-op for
    // `devices:` (RDC/real devices), which has no env-carrying channel at all.
    // ProcessInfo.processInfo.environment is the XCUITest analogue of Android's
    // InstrumentationRegistry.getArguments().
    func testLogin() {
        let env = ProcessInfo.processInfo.environment
        let username = env["username"] ?? "bod@example.com"
        let password = env["password"] ?? "10203040"

        let page = PageObject()

        page.moreButton.tap()
        // "LogOut-menu-item" is the same control used for both Login and Log Out,
        // depending on session state - we're logged out here, so it opens Login.
        page.logOutButton.tap()

        page.usernameField.tap()
        page.usernameField.typeText(username)

        page.passwordField.tap()
        page.passwordField.typeText(password)

        // Dismiss the keyboard so it doesn't cover the login button.
        app.keyboards.buttons["Return"].tap()

        page.loginButton.tap()

        XCTAssert(page.catalogScreen.waitForExistence(timeout: 5))
    }
}
