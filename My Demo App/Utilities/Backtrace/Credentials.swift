//
//  Credentials.swift
//  My Demo App
//
//  SDK configuration for the Backtrace + Sauce Mobile Beta demo.
//
//  Values come from Info.plist keys that Xcode fills from build settings declared in
//  Config/Demo.xcconfig and Config/Local.xcconfig. Empty values disable the SDK.
import Foundation

enum Credentials {
    /// Backtrace universe name (Info.plist `backtraceUniverse` <- BACKTRACE_UNIVERSE)
    static var universeName: String { infoValue("backtraceUniverse") }
    /// Backtrace submission token for that universe (Info.plist `backtraceToken` <- BACKTRACE_TOKEN)
    static var backtraceToken: String { infoValue("backtraceToken") }
    /// Sauce Mobile Beta app token (Info.plist `sauceMobileBetaToken` <- SAUCE_MOBILE_BETA_TOKEN)
    static var sauceMobileBetaToken: String { infoValue("sauceMobileBetaToken") }
    /// Reported as `sauce.environment` on both SDKs (Info.plist `sauceEnvironment`, default "beta")
    static var environment: String {
        let value = infoValue("sauceEnvironment")
        return value.isEmpty ? "beta" : value
    }
    /// Optional Mobile App Distribution id, reported as `mad.distribution_id` only when set
    static var distributionId: String { infoValue("sauceDistributionId") }

    static var isBacktraceConfigured: Bool { !universeName.isEmpty && !backtraceToken.isEmpty }
    static var isSauceMobileBetaConfigured: Bool { !sauceMobileBetaToken.isEmpty }

    /// https://docs.saucelabs.com/error-reporting/project-setup/submission-url/
    static var backtraceSubmissionUrl: String {
        return "https://submit.backtrace.io/\(universeName)/\(backtraceToken)/plcrash"
    }

    private static func infoValue(_ key: String) -> String {
        let raw = Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
        return raw.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
