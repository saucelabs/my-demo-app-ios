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
    
    let fileUrl = createAndWriteFile("Swaglabs-app-log.txt")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        TestFairyWrapper.begin()
        FaceIdlocalAuthentication()
        Utils.setProductList()
        // Backtrace
        let backtraceCredentials = BacktraceCredentials(endpoint: URL(string: Credentials.backtraceUrl as String)!, token: Credentials.backtraceToken as String)
        // Database
        let backtraceDatabaseSettings = BacktraceDatabaseSettings()
        backtraceDatabaseSettings.maxRecordCount = 10
        // Client Configuration
        let backtraceConfiguration = BacktraceClientConfiguration(credentials: backtraceCredentials,
                                                                  dbSettings: backtraceDatabaseSettings,
                                                                  reportsPerMin: 10,
                                                                  allowsAttachingDebugger: true,
                                                                  detectOOM: true)
        BacktraceClient.shared = try? BacktraceClient(configuration: backtraceConfiguration)
        // Attributes
        BacktraceClient.shared?.attributes = ["Swaglabs": "Demo session", "testing": true]
        // Attachment
        if let fileUrl = fileUrl,
           fileUrl.path != "",
           FileManager.default.fileExists(atPath: fileUrl.path) {
            BacktraceClient.shared?.attachments.append(fileUrl)
        }
        // Delegate
        BacktraceClient.shared?.delegate = self
        
        do {
            try throwingFunc()
        } catch {
            BacktraceClient.shared?.send(attachmentPaths: []) { (result) in
                print("AppDelegate:Result:\(result)")
            }
        }
        // Lof level
        BacktraceClient.shared?.loggingDestinations = [BacktraceBaseDestination(level: .debug)]
        // Enable error free metrics https://docs.saucelabs.com/error-reporting/web-console/overview/#stability-metrics-widgets
        BacktraceClient.shared?.metrics.enable(settings: BacktraceMetricsSettings())
        // Enable breadcrumbs https://docs.saucelabs.com/error-reporting/web-console/debug/#breadcrumbs-section
        BacktraceClient.shared?.enableBreadcrumbs()
        // Add breadcrumb
        _ = BacktraceClient.shared?.addBreadcrumb("My Breadcrumb",
                                                  attributes: [:],
                                                  type: .navigation,
                                                  level: .info)
        
        return true
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
        print("AppDelegate: willSend")
        return report
    }
    
    func willSendRequest(_ request: URLRequest) -> URLRequest {
        print("AppDelegate: willSendRequest")
        return request
    }
    
    func serverDidRespond(_ result: BacktraceResult) {
        print("AppDelegate:serverDidRespond: \(result)")
    }
    
    func connectionDidFail(_ error: Error) {
        print("AppDelegate: connectionDidFail: \(error)")
    }
    
    func didReachLimit(_ result: BacktraceResult) {
        print("AppDelegate: didReachLimit: \(result)")
    }
}
