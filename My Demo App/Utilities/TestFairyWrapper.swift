//
//  TestFairyWrapper.swift
//  My Demo App
//

import Foundation

class TestFairyWrapper {
    static func begin() {
        instance.begin()
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
    
    private static var instance: TestFairyProtocol {
        get {
            guard let testfairyEnabled = Bundle.main.infoDictionary?["testfairyEnabled"] as? Bool else {
                return NoOpTestFairyWrapper()
            }
            
            return testfairyEnabled ? DefaultTestFairyWrapper() : NoOpTestFairyWrapper()
        }
    }
}

protocol TestFairyProtocol {
    func begin()
    func showFeedbackForm()
    func reportBug(_ takeScreenshot: Bool)
    func remoteSupport()
    func customFeedback()
    func log(_ message: String!)
    func resetFeedbackForm()
}

class NoOpTestFairyWrapper: TestFairyProtocol {
    func begin() {}
    func showFeedbackForm() {}
    func reportBug(_ takeScreenshot: Bool) {}
    func remoteSupport() {}
    func customFeedback() {}
    func log(_ message: String!) {}
    func resetFeedbackForm() {}
}

class DefaultTestFairyWrapper: TestFairyProtocol {
    public let TESTFAIRY_APP_TOKEN = ""
    
    public func begin() {
        TestFairy.begin(TESTFAIRY_APP_TOKEN)
    }
    
    public func showFeedbackForm() {
        TestFairy.showFeedbackForm()
    }
    
    public func reportBug(_ takeScreenshot: Bool) {
        TestFairy.showFeedbackForm(TESTFAIRY_APP_TOKEN, takeScreenshot: takeScreenshot)
    }
    
    public func remoteSupport() {
        TestFairy.stop()
        TestFairy.showFeedbackForm(TESTFAIRY_APP_TOKEN, takeScreenshot: false)
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
