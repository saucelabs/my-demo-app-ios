//
//  TestFairyWrapper.swift
//  My Demo App
//

import Foundation

class TestFairyWrapper {
    static func begin() {
        if !isEnabled {
            print("Sauce Mobile Beta: disabled (testfairyEnabled=\(plistEnabled), token and endpoint configured=\(Credentials.isSauceMobileBetaConfigured)) — skipping begin")
            let endpoint = Credentials.sauceMobileBetaEndpoint
            if !endpoint.isEmpty && !Credentials.isSauceMobileBetaEndpointValid {
                print("Sauce Mobile Beta: SAUCE_MOBILE_BETA_ENDPOINT is \"\(endpoint)\".")
            }
        }
        instance.begin()
    }
    static func enableCrashHandler() {
        instance.enableCrashHandler()
    }
    static func showFeedbackForm() {
        instance.showFeedbackForm()
    }
    static func reportBug(_ takeScreenshot: Bool) {
        instance.reportBug(takeScreenshot)
    }
    static func remoteSupport() {
        instance.remoteSupport()
    }
    static func customFeedback() {
        instance.customFeedback()
    }
    static func log(_ message: String!) {
        instance.log(message)
    }
    static func resetFeedbackForm() {
        instance.resetFeedbackForm()
    }
    /// App-owned session attributes shared with Backtrace (call before `begin()`; the SDK keeps them and attaches them to every session it starts).
    static func setAttributes(_ attributes: [String: String]) {
        instance.setAttributes(attributes)
    }
    /// Stops the current session and starts a new one; the SDK generates a new `sauce.correlation_id` for it and writes it to
    /// `BacktraceClient.shared` (the SDK links Backtrace through its public API at every session start, no glue code needed).
    static func restartSession() {
        instance.restartSession()
    }
    /// The SDK-generated correlation id of the current session; nil before the first session start or when Mobile Beta is disabled.
    static func sessionCorrelationId() -> String? {
        return instance.sessionCorrelationId()
    }

    /// Mobile Beta runs only when Info.plist `testfairyEnabled` is true AND both the app token and the server endpoint are configured.
    static var isEnabled: Bool {
        return plistEnabled && Credentials.isSauceMobileBetaConfigured
    }

    private static var plistEnabled: Bool {
        return Bundle.main.infoDictionary?["testfairyEnabled"] as? Bool ?? false
    }

    private static var instance: TestFairyProtocol {
        get {
            return isEnabled ? DefaultTestFairyWrapper() : NoOpTestFairyWrapper()
        }
    }
}

protocol TestFairyProtocol {
    func begin()
    func enableCrashHandler()
    func showFeedbackForm()
    func reportBug(_ takeScreenshot: Bool)
    func remoteSupport()
    func customFeedback()
    func log(_ message: String!)
    func resetFeedbackForm()
    func setAttributes(_ attributes: [String: String])
    func restartSession()
    func sessionCorrelationId() -> String?
}

class NoOpTestFairyWrapper: TestFairyProtocol {
    func begin() {}
    func enableCrashHandler() {}
    func showFeedbackForm() {}
    func reportBug(_ takeScreenshot: Bool) {}
    func remoteSupport() {}
    func customFeedback() {}
    func log(_ message: String!) {}
    func resetFeedbackForm() {}
    func setAttributes(_ attributes: [String: String]) {}
    func restartSession() {}
    func sessionCorrelationId() -> String? { return nil }
}

class DefaultTestFairyWrapper: TestFairyProtocol {
    /// Sauce Mobile Beta app token (Config/Local.xcconfig -> Info.plist -> Credentials).
    private var appToken: String { Credentials.sauceMobileBetaToken }

    /// Sauce Mobile Beta server endpoint (Config/Local.xcconfig -> Info.plist -> Credentials).
    /// Required: the SDK's built-in default server is no longer in service.
    private var serverEndpoint: String { Credentials.sauceMobileBetaEndpoint }

    public func begin() {
        // Sauce Mobile Beta (crashless): Backtrace owns crash reporting.
        // The Server Endpoint from Organization Settings > SDK Settings must be set before begin.
        TestFairy.setServerEndpoint(serverEndpoint)
        TestFairy.beginWithoutCrashHandler(appToken)
        // The SDK generates the id synchronously at begin, so it is already current here.
        print("Sauce Mobile Beta: session started, sauce.correlation_id: \(TestFairy.sessionCorrelationId() ?? "nil")")
    }

    public func setAttributes(_ attributes: [String: String]) {
        for (key, value) in attributes {
            if !TestFairy.setAttribute(key, withValue: value) {
                print("Sauce Mobile Beta rejected attribute \(key)")
            }
        }
    }

    public func restartSession() {
        // stop() ends the current session; resume() starts a new one, which rotates sauce.correlation_id.
        TestFairy.stop()
        TestFairy.resume()
    }

    public func sessionCorrelationId() -> String? {
        return TestFairy.sessionCorrelationId()
    }

    public func enableCrashHandler() {
        // No-op in the crashless Sauce Mobile Beta artifact.
    }
    
    public func showFeedbackForm() {
        TestFairy.showFeedbackForm()
    }
    
    public func reportBug(_ takeScreenshot: Bool) {
        TestFairy.showFeedbackForm(appToken, takeScreenshot: takeScreenshot)
    }
    
    public func remoteSupport() {
        TestFairy.stop()
        TestFairy.showFeedbackForm(appToken, takeScreenshot: false)
    }
    
    public func customFeedback() {
        let options = DefaultTestFairyWrapper.createFeedbackForm()
        TestFairy.setTestFairyFeedbackOptions(options)
        TestFairy.showFeedbackForm()
    }
    
    public func log(_ message: String!) {
        print("\(message ?? "")")
        TestFairy.log(message)
    }
    
    private static func createFeedbackForm() -> TestFairyFeedbackOptions {
        return TestFairyFeedbackOptions.create { builder in
            builder?.title = "My Demo Feedback From"

            // See https://docs.testfairy.com/SDK/Customizing_feedback_dialog.html#ios-objc for more ways to customize your feedback form
            builder?.feedbackFormFields = [
                TestFairyStringFeedbackFormField(
                    attribute: ":userId",
                    label: nil,
                    placeholder: "Your Email",
                    defaultValue: ""
                )!,
                TestFairyStringFeedbackFormField(
                    attribute: "phone",
                    label: nil,
                    placeholder: "Your Phone Number",
                    defaultValue: ""
                )!,
                TestFairySelectFeedbackFormField(
                    attribute: "type",
                    label: "Is this a bug or feature?",
                    values: ["Bug": "bug", "Feature": "feature"],
                    defaultValue: "Bug"
                )!,
                TestFairyTextAreaFeedbackFormField(
                    attribute: ":text",
                    placeholder: "Your Message",
                    defaultValue: ""
                )!,
            ]
        }
    }
    
    public func resetFeedbackForm() {
        TestFairy.stop()
        TestFairy.setTestFairyFeedbackOptions(TestFairyFeedbackOptions.create { _ in})
    }
}
