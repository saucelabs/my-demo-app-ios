//
//  TestFairyWrapper.swift
//  My Demo App
//

import Foundation

class TestFairyWrapper {
    static func begin() {
        if !isEnabled {
            print("Sauce Mobile Beta: disabled (testfairyEnabled=\(plistEnabled), token configured=\(Credentials.isSauceMobileBetaConfigured)) — skipping begin")
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
    /// Session-level attributes shared with Backtrace (call before `begin()`; the SDK keeps them and attaches them to every session it starts).
    static func setAttributes(_ attributes: [String: String]) {
        instance.setAttributes(attributes)
    }
    /// Observe session start/failure.
    /// Call before `begin()` so the first session is observed.
    static func observeSessions(_ handler: @escaping (SauceMobileBetaSessionEvent) -> Void) {
        instance.observeSessions(handler)
    }

    /// Mobile Beta runs only when Info.plist `testfairyEnabled` is true AND a token is configured.
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

enum SauceMobileBetaSessionEvent {
    /// A session started; `sessionUrl` is the recording's address in the Sauce Mobile Beta console.
    case started(sessionUrl: String?)
    case failed
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
    func observeSessions(_ handler: @escaping (SauceMobileBetaSessionEvent) -> Void)
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
    func observeSessions(_ handler: @escaping (SauceMobileBetaSessionEvent) -> Void) {}
}

class DefaultTestFairyWrapper: TestFairyProtocol {
    /// Sauce Mobile Beta app token (Config/Local.xcconfig -> Info.plist -> Credentials).
    private var appToken: String { Credentials.sauceMobileBetaToken }
    /// The SDK keeps a strong reference to the delegate and `setSessionStateDelegate` ADDS a delegate rather than replacing it,
    /// so register once per launch; we also hold it so the observer's lifetime is explicit.
    private static var sessionObserver: SessionObserver?

    public func begin() {
        // Sauce Mobile Beta (crashless): Backtrace owns crash reporting.
        TestFairy.beginWithoutCrashHandler(appToken)
    }

    public func setAttributes(_ attributes: [String: String]) {
        for (key, value) in attributes {
            if !TestFairy.setAttribute(key, withValue: value) {
                print("Sauce Mobile Beta rejected attribute \(key)")
            }
        }
    }

    public func observeSessions(_ handler: @escaping (SauceMobileBetaSessionEvent) -> Void) {
        let observer = SessionObserver(handler: handler)
        DefaultTestFairyWrapper.sessionObserver = observer
        TestFairy.setSessionStateDelegate(observer)
    }

    private final class SessionObserver: NSObject, TestFairySessionStateDelegate {
        private let handler: (SauceMobileBetaSessionEvent) -> Void

        init(handler: @escaping (SauceMobileBetaSessionEvent) -> Void) {
            self.handler = handler
        }

        // Fires for every session the SDK starts (including the new session created after `TestFairy.stop()` + resume), so consumers must overwrite, not set once.
        func sessionStarted() {
            handler(.started(sessionUrl: TestFairy.sessionUrl()))
        }

        func sessionFailed() {
            handler(.failed)
        }
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
