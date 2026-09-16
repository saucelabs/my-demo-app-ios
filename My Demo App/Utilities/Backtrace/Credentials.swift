//
//  Credentials.swift
//  My Demo App
//
//  SDK credentials for the Backtrace + Sauce Mobile Beta demo.
import Foundation

enum Credentials {
    /// Backtrace universe name
    static let universeName = ""
    /// Backtrace submission token for that universe
    static let backtraceToken = ""
    /// Sauce Mobile Beta app token
    static let sauceMobileBetaToken = ""

    /// https://docs.saucelabs.com/error-reporting/project-setup/submission-url/
    static var backtraceSubmissionUrl: String {
        return "https://submit.backtrace.io/\(universeName)/\(backtraceToken)/plcrash"
    }
}
