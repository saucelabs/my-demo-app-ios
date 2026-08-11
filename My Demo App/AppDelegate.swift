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

        // Coexistence pattern: Backtrace initializes FIRST and is the sole crash owner
        // the Sauce Mobile Beta SDK starts crashless afterwards
        // (beginWithoutCrashHandler never installs a crash handler).
        startBacktrace()
        TestFairyWrapper.begin()

        // Shared correlation attribute so a Backtrace report and the SMB session recording can be joined across both consoles.
        let correlationId = UUID().uuidString
        BacktraceClient.shared?.attributes["sauce.correlation_id"] = correlationId
        TestFairy.setAttribute("sauce.correlation_id", withValue: correlationId)

        FaceIdlocalAuthentication()
        Utils.setProductList()
        return true
    }

    private func startBacktrace() {
        guard let submissionUrl = URL(string: Credentials.backtraceSubmissionUrl) else {
            print("Backtrace: invalid or missing submission URL — skipping init")
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
        BacktraceClient.shared = try? BacktraceClient(configuration: configuration)
        BacktraceClient.shared?.delegate = self
        BacktraceClient.shared?.loggingDestinations = [BacktraceBaseDestination(level: .debug)]
        // Error-free metrics + breadcrumbs, as in the Backtrace demo template.
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

