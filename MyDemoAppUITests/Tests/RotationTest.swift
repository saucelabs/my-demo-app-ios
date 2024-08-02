import XCTest

class RotationTest: MyDemoAppTestBase {
    func testScreenRotation() {
        // You can only control the orientation of the device, not the app
        // So use the `XCUIDevice.shared` which represents the physical device
        let device = XCUIDevice.shared
        
        // We start in portrait, validate that
        XCTAssertEqual(device.orientation, UIDeviceOrientation.portrait)

        // Rotate to landscapeLeft
        device.orientation = .landscapeLeft

        // For demoing purpose
        sleep(15)

        // Validate we are now in landscapeLeft
        XCTAssertEqual(device.orientation, UIDeviceOrientation.landscapeLeft)
        
        // Rotate to landscapeRight
        device.orientation = .landscapeRight

        // For demoing purpose
        sleep(15)

        // Validate we are now in landscapeRight
        XCTAssertEqual(device.orientation, UIDeviceOrientation.landscapeRight)

        // Rotate back to portrait
        device.orientation = .portrait

        // For demoing purpose
        sleep(15)

        // Validate we are now in portrait again
        XCTAssertEqual(device.orientation, UIDeviceOrientation.portrait)
    }
}
