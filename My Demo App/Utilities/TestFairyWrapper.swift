//
//  TestFairyWrapper.swift
//  My Demo App
//

import Foundation

class TestFairyWrapper {
    public static let TESTFAIRY_APP_TOKEN = ""
    
    public static func begin() {
        TestFairy.begin(TESTFAIRY_APP_TOKEN)
    }
    
    public static func showFeedbackForm() {
        TestFairy.showFeedbackForm()
    }
    
    public static func reportBug(_ takeScreenshot: Bool) {
        TestFairy.showFeedbackForm(TESTFAIRY_APP_TOKEN, takeScreenshot: takeScreenshot)
    }
    
    public static func remoteSupport() {
        TestFairy.stop()
        TestFairy.showFeedbackForm(TESTFAIRY_APP_TOKEN, takeScreenshot: false)
    }
    
    public static func customFeedback() {
        let options = TestFairyWrapper.createFeedbackForm()
        TestFairy.setTestFairyFeedbackOptions(options)
        TestFairy.showFeedbackForm()
    }
    
    public static func log(_ message: String!) {
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
    
    public static func resetFeedbackForm() {
        TestFairy.stop()
        TestFairy.setTestFairyFeedbackOptions(TestFairyFeedbackOptions.create { _ in})
    }
}
