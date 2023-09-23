import XCTest

class SnapshotTests: MyDemoAppTestBase {
    func testProductListingPageSnapshot(){
        let snapshotScreen = app.windows.firstMatch.screenshot().image
        sauceAssertSnapshot(matching: snapshotScreen,as: .image(), file: #file)
    }
    
    func testNoReference(){
        let snapshotScreen = app.windows.firstMatch.screenshot().image
        sauceAssertSnapshot(matching: snapshotScreen,as: .image(), file: #file)
    }
    
    
    func testProductListingPageFirstItemSnapshot(){
        let snapshotElement = app.collectionViews.cells.element(boundBy: 0).screenshot().image
        sauceAssertSnapshot(matching: snapshotElement, as: .image(), file: #file)
    }
}
