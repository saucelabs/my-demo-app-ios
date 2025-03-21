//
//  Credentials.swift
//  My Demo App
//
//  Created by Melek R on 2025-03-19.
//

import Foundation

/// https://docs.saucelabs.com/error-reporting/project-setup/submission-url/
class Credentials {
    
    private static let plistSecrets: NSDictionary? = {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }()
    
    /// [Backtrace URL]
    static var backtraceUrl: String {
        return "https://\(universeName).sp.backtrace.io:6098"
    }
    
    /// [Submission URL]
    static var backtraceSubmissionUrl: String {
        return "https://submit.backtrace.io/\(universeName)/\(backtraceToken)/plcrash"
    }
    
    /// [Universe Name]
    static var universeName: String {
        get {
            let saved = UserDefaults.standard.string(forKey: "UNIVERSE_NAME")
            if let saved, !saved.isEmpty {
                return saved
            }
            let defaultValue = plistSecrets?["UNIVERSE_NAME"] as? String
            return defaultValue ?? ""
        }
        set {
            let trimmed = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty {
                UserDefaults.standard.removeObject(forKey: "UNIVERSE_NAME")
            } else {
                UserDefaults.standard.set(trimmed, forKey: "UNIVERSE_NAME")
            }
        }
    }
    
    /// [ Token]
    static var backtraceToken: String {
        get {
            let saved = UserDefaults.standard.string(forKey: "BACKTRACE_TOKEN")
            if let saved, !saved.isEmpty {
                return saved
            }
            let defaultValue = plistSecrets?["BACKTRACE_TOKEN"] as? String
            return defaultValue ?? ""
        }
        set {
            let trimmed = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty {
                UserDefaults.standard.removeObject(forKey: "BACKTRACE_TOKEN")
            } else {
                UserDefaults.standard.set(trimmed, forKey: "BACKTRACE_TOKEN")
            }
        }
    }
}
