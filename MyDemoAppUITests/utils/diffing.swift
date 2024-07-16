import SnapshotTesting
import XCTest

public func sauceAssertSnapshot<Value, Format>(
    matching value: @autoclosure () throws -> Value,
    as snapshotting: Snapshotting<Value, Format>,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString,
    testName: String = #function,
    line: UInt = #line
) {
    // This part alters the name of the screenshot, feel free to change/remove it
    // Make sure that if you change/remove it, that the current snapshot names are altered
    let device = UIDevice.current
    let deviceName = [device.name, device.systemName, device.systemVersion].joined(separator: " ")
    // The output will look like this testTakeSnapshot.iPhone-13-iOS-15-5.png
    let name = name.map { $0 + "-\(deviceName)" } ?? "\(deviceName)"
    
    // This is needed to determine if the tests are running on Sauce Labs
    let failure: String?
    let isSauce = (ProcessInfo.processInfo.environment["IS_SAUCE"]?.lowercased() ?? "false") == "true"

    if isSauce {
        // The snapshot directory needs to be set for Sauce Labs so it can:
        // - use the correct images as the "baseline/actual" images
        // - store and upload newly/recorded images to the Sauce Labs assets
        print("Running Tests on Sauce Labs")
        
        // Handle the Sauce Labs logic
        let snapshotReferenceDir = ProcessInfo.processInfo.environment["SNAPSHOT_REFERENCE_DIR"]!
        let callingFilePath = String(describing: file)
        let fileNameWithoutExtension = ((callingFilePath as NSString).lastPathComponent as NSString).deletingPathExtension
        let snapshotDirectory = "/\(snapshotReferenceDir)/__Snapshots__/\(fileNameWithoutExtension)"
        
        // Extra debug logs for Sauce
        print("snapshotDirectory = \(snapshotDirectory)")
        print("__XCODE_BUILT_PRODUCTS_DIR_PATHS has \((ProcessInfo.processInfo.environment["__XCODE_BUILT_PRODUCTS_DIR_PATHS"]?.lowercased() ?? "NOT") == "") been set.")
        
        failure = verifySnapshot(
          matching: try value(),
          as: snapshotting,
          named: name,
          record: recording,
          snapshotDirectory: snapshotDirectory,
          timeout: timeout,
          file: file,
          testName: testName
        )
        
    } else {
        print("Running Tests locally")
        
        // You can alter your logic here
        failure = verifySnapshot(
          matching: try value(),
          as: snapshotting,
          named: name,
          record: recording,
          timeout: timeout,
          file: file,
          testName: testName
        )
    }
    
    guard let message = failure else { return }
    XCTFail(message, file: file, line: line)
}
