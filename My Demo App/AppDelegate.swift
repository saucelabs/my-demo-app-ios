//
//  AppDelegate.swift
//  My Demo App
//
//  Created by Mubashir on 15/09/21.
//

import UIKit
import LocalAuthentication
import Backtrace

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Coexistence pattern: Backtrace initializes FIRST and is the sole crash owner;
        // the Sauce Mobile Beta SDK starts crashless afterwards
        // (beginWithoutCrashHandler never installs a crash handler).
        //
        // Both SDKs receive the same attributes, generated once per launch BEFORE either SDK starts.
        // `sauce.correlation_id` (a lowercase UUID v4) joins a Backtrace report with its Sauce Mobile Beta session recording across the two consoles.
        let sharedAttributes = makeSharedAttributes()
        startBacktrace(sharedAttributes: sharedAttributes)

        // Reverse link: once a Mobile Beta session exists, record its URL on the Backtrace side.
        // A launch can produce several sessions (stop()/resume), so the value is overwritten each time.
        // Used for Testing.
        TestFairyWrapper.observeSessions { event in
            DispatchQueue.main.async {
                guard let client = BacktraceClient.shared else { return }
                var attributes = client.attributes
                switch event {
                case .started(let sessionUrl):
                    attributes["sauce.mobile_beta.session_started"] = "true"
                    attributes["sauce.mobile_beta.session_url"] = sessionUrl ?? ""
                case .failed:
                    attributes["sauce.mobile_beta.session_started"] = "false"
                    attributes["sauce.mobile_beta.session_url"] = ""
                }
                client.attributes = attributes
            }
        }
        TestFairyWrapper.setAttributes(sharedAttributes)
        TestFairyWrapper.begin()

        FaceIdlocalAuthentication()
        Utils.setProductList()
        return true
    }

    /// Attributes carried by both SDKs (identical key set on iOS, Android and React Native).
    private func makeSharedAttributes() -> [String: String] {
        let info = Bundle.main.infoDictionary ?? [:]
        let version = info["CFBundleShortVersionString"] as? String ?? "unknown"
        let build = info["CFBundleVersion"] as? String ?? "unknown"
        var attributes: [String: String] = [
            "sauce.correlation_id": UUID().uuidString.lowercased(),
            "sauce.sdk.coexistence_mode": "backtrace_crash_owner",
            "sauce.environment": Credentials.environment,
            "sauce.release": "\(Bundle.main.bundleIdentifier ?? "unknown")@\(version)",
            "sauce.dist": build,
        ]
        if !Credentials.distributionId.isEmpty {
            attributes["mad.distribution_id"] = Credentials.distributionId
        }
        return attributes
    }

    private func startBacktrace(sharedAttributes: [String: String]) {
        guard Credentials.isBacktraceConfigured,
              let submissionUrl = URL(string: Credentials.backtraceSubmissionUrl) else {
            print("Backtrace: backtraceUniverse/backtraceToken not configured (Config/Local.xcconfig) — skipping init")
            return
        }
        let credentials = BacktraceCredentials(submissionUrl: submissionUrl)

        let dbSettings = BacktraceDatabaseSettings()
        dbSettings.maxRecordCount = 10

        let configuration = BacktraceClientConfiguration(credentials: credentials,
                                                         dbSettings: dbSettings,
                                                         reportsPerMin: 10,
                                                         allowsAttachingDebugger: true,
                                                         detectOOM: true)
        do {
            BacktraceClient.shared = try BacktraceClient(configuration: configuration)
        } catch {
            print("Backtrace: initialization failed — \(error)")
            return
        }
        // First statement after init: PLCrashReporter's handlers are already installed and only this setter writes attributes into native crash reports,
        // A crash before this line would carry no correlation id. One assignment, String values only.
        BacktraceClient.shared?.attributes = sharedAttributes
        BacktraceClient.shared?.delegate = self
        BacktraceClient.shared?.loggingDestinations = [BacktraceBaseDestination(level: .debug)]
        // Error-free metrics + breadcrumbs
        BacktraceClient.shared?.metrics.enable(settings: BacktraceMetricsSettings())
        BacktraceClient.shared?.enableBreadcrumbs()
        _ = BacktraceClient.shared?.addBreadcrumb("Application finished launching",
                                                  attributes: ["backtrace": "enabled",
                                                               "sauce_mobile_beta": "crashless"],
                                                  type: .navigation,
                                                  level: .info)
    }
    
    func FaceIdlocalAuthentication() -> Void {
           let laContext = LAContext()
           var error: NSError?
           let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
           
           if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {
               
               if let laError = error {
                   print("laError - \(laError)")
                   return
               }
               
               var localizedReason = "Unlock device"
               if #available(iOS 11.0, *) {
                   if (laContext.biometryType == LABiometryType.faceID) {
                       localizedReason = "Unlock using Face ID"
                       print("FaceId support")
                    Engine.sharedInstance.isFaceSupported = true
                   } else {
                       print("No FaceId support")
                    Engine.sharedInstance.isFaceSupported = false
                   }
               } else {
                   // Fallback on earlier versions
               }
               
               
//               laContext.evaluatePolicy(biometricsPolicy, localizedReason: localizedReason, reply: { (isSuccess, error) in
//                   
//                   DispatchQueue.main.async(execute: {
//                       
//                       if let laError = error {
//                           print("laError - \(laError)")
//                       } else {
//                           if isSuccess {
//                              
//                           }
//                       }
//                       
//                   })
//               })
           }
       }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        TestFairyWrapper.log("Device Token: \(token)")
        NotificationCenter.default.post(
            name: Notification.Name("RegisterForRemoteNotificationsWithDeviceToken"),
            object: nil,
            userInfo: ["token": token]
        )
    }

    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        TestFairyWrapper.log("Failed to register: \(error)")
        NotificationCenter.default.post(
            name: Notification.Name("RegisterForRemoteNotificationsWithError"),
            object: nil,
            userInfo: ["error": error]
        )
    }
}

extension AppDelegate: BacktraceClientDelegate {
    func willSend(_ report: BacktraceReport) -> BacktraceReport {
        print("Backtrace: willSend")
        return report
    }

    func willSendRequest(_ request: URLRequest) -> URLRequest {
        print("Backtrace: willSendRequest")
        return request
    }

    func serverDidRespond(_ result: BacktraceResult) {
        print("Backtrace: serverDidRespond: \(result)")
    }

    func connectionDidFail(_ error: Error) {
        print("Backtrace: connectionDidFail: \(error)")
    }

    func didFinishSending(_ result: BacktraceResult) {
        print("Backtrace: didFinishSending: \(result)")
    }
}

