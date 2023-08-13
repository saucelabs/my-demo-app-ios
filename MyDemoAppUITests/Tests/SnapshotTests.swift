import SnapshotTesting
import XCTest

class SnapshotTests: MyDemoAppTestBase {
    let backPack = "Sauce Labs Backpack"
    
    func assertSnapshot<Value, Format>(
      matching value: @autoclosure () throws -> Value,
      as snapshotting: Snapshotting<Value, Format>,
      named name: String? = nil,
      record recording: Bool = false,
      timeout: TimeInterval = 5,
      file: StaticString = #file,
      testName: String = #function,
      line: UInt = #line
      ) {
      // Name will either be "{name}-{deviceName}" or "{deviceName}" if name is nil.
      let device = UIDevice.current
      let deviceName = [device.name, device.systemName, device.systemVersion].joined(separator: " ")
      let name = name
        .map { $0 + "-\(deviceName)" }
        ?? "\(deviceName)"
      
          SnapshotTesting.assertSnapshot(
        matching: try value(),
        as: snapshotting,
        named: name,
        record: recording,
        timeout: timeout,
        file: file,
        testName: testName,
        line: line
      )
    }

    func testProductListingPageSnapshot(){
        let snapshotScreen = app.windows.firstMatch.screenshot().image
        assertSnapshot(matching: snapshotScreen, as: .image())
    }
    
    
    func testProductListingPageFirstItemSnapshot(){
        let snapshotElement = app.collectionViews.cells.element(boundBy: 0).screenshot().image
        assertSnapshot(matching: snapshotElement, as: .image())
    }
}
