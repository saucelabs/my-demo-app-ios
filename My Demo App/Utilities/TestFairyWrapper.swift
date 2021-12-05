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
    
    public static func customFeedback(_ options: TestFairyFeedbackOptions) {
        TestFairy.setTestFairyFeedbackOptions(options)
        TestFairy.showFeedbackForm()
    }
    
    public static func resetFeedbackForm() {
        TestFairy.stop()
        TestFairy.setTestFairyFeedbackOptions(TestFairyFeedbackOptions.create { _ in})
    }
}
