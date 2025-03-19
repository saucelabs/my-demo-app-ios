//
//  Credentials.swift
//  My Demo App
//
//  Created by Melek R on 2025-03-19.
//

/// https://docs.saucelabs.com/error-reporting/project-setup/submission-url/
class Credentials {
    
    private static let secrets: NSDictionary? = {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }()
    
    /// [Universe Name]
    static var universeName: String {
        return secrets?["UNIVERSE_NAME"] as? String ?? ""
    }
    
    /// [Submission token]
    static var backtraceToken: String {
        return secrets?["BACKTRACE_TOKEN"] as? String ?? ""
    }
    
    /// [Submission URL]
    static var backtraceUrl: String {
        return "https://\(universeName).sp.backtrace.io:6098"
    }
    
    static var backtraceSubmissionUrl: String {
        return "https://submit.backtrace.io/\(universeName)/\(backtraceToken)/plcrash"
    }
}
