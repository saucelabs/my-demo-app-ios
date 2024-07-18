import XCTest

class FailedTests: MyDemoAppTestBase {
    let backPack = "Can't find me"

    func testProductDetailsPrice() throws {
        PageObject().selectItemByName(itemName: backPack).tap()
        XCTAssert(PageObject().getPrice(price: "$ 29.99").exists)
    }

    func testProductDetailsDecreaseNumberOfItems() throws {
        PageObject().selectItemByName(itemName: backPack).tap()
        PageObject().substractAmountButton.tap()
        XCTAssert(PageObject().productAmount(amount: "0").exists)
    }

    func testFailedProductDetailsPrice() throws {
        PageObject().selectItemByName(itemName: backPack).tap()
        XCTAssert(PageObject().getPrice(price: "$ 30.00").exists)
    }

    func testFailedProductDetailsDecreaseNumberOfItems() throws {
        PageObject().selectItemByName(itemName: backPack).tap()
        PageObject().substractAmountButton.tap()
        XCTAssert(PageObject().productAmount(amount: "1").exists)
    }
}
