import Foundation
import JavaScriptCore
import os

@objc public class ProxyFinder: NSObject {
    @objc public static let shared = ProxyFinder()

    @objc public func swiftGetProxy(_ destinationUrl: String, destinationHost: String) -> String {
        
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "network")

        logger.error("gilm: swiftGetProxy")
        guard let systemProxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any] else {
            logger.error("gilm: 10 failed")
            return ""
        }
        
        logger.error("gilm: success 1")

        let proxyAutoConfigEnable = systemProxySettings["ProxyAutoConfigEnable"] as? Int ?? 0
        logger.error("gilm: 17, proxyAutoConfigEnable is \(proxyAutoConfigEnable)")

        if proxyAutoConfigEnable == 1 {
            logger.error("gilm: 20")
            guard let pacUrl = systemProxySettings["ProxyAutoConfigURLString"] as? String,
                  let url = URL(string: pacUrl) else {
                logger.error("gilm: 23 failed")
                return ""
            }

            logger.error("gilm: 27 url is \(url)")
            logger.error("gilm: 27 pacUrl is \(pacUrl)")
            var proxyUrl = ""

            let semaphore = DispatchSemaphore(value: 0)

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                defer {
                    semaphore.signal()
                }

                if let data = data {
                    if let pacContent = String(data: data, encoding: .utf8) {
                        let proxies = CFNetworkCopyProxiesForAutoConfigurationScript(pacContent as CFString, CFURLCreateWithString(kCFAllocatorDefault, destinationUrl as CFString, nil), nil)!.takeUnretainedValue() as? [[AnyHashable: Any]] ?? [];

                        if (proxies.count > 0) {
                            let proxy = proxies[0]

                            if(proxy[kCFProxyTypeKey] as! CFString == kCFProxyTypeHTTP || proxy[kCFProxyTypeKey] as! CFString == kCFProxyTypeHTTPS) {
                                let host = proxy[kCFProxyHostNameKey] as? String ?? "null"
                                let port = proxy[kCFProxyPortNumberKey] as? Int ?? 0

                                logger.error("gilm 49: \(host), \(port)")
                                if (host == "null" || port == 0) {
                                    return
                                }

                                proxyUrl = "http://" + host + ":" + String(port)
                                logger.error("gilm: 54: proxyUrl is: \(proxyUrl)")
                            }
                        }
                    }
                } else if let error = error {
                    // Handle Error
                    logger.error("gilm: got error \(error)")
                }
            }

            task.resume()
            semaphore.wait()
            logger.error("gilm: 66 done")

            return proxyUrl
        }

        logger.error("gilm: 71")
        if let httpSEnable = systemProxySettings["HTTPSEnable"] as? Int, httpSEnable == 1,
           destinationUrl.starts(with: "https") {
            if let host = systemProxySettings["HTTPSProxy"] as? String,
               let port = systemProxySettings["HTTPSPort"] as? String {
                logger.error("gilm: 76: \(host), \(port)")
                return "https://\(host):\(port)"
            }
        }

        logger.error("gilm: 81")
        if let httpEnable = systemProxySettings["HTTPEnable"] as? Int, httpEnable == 1 {
            if let host = systemProxySettings["HTTPProxy"] as? String,
               let port = systemProxySettings["HTTPPort"] as? String {
                logger.error("gilm: 85: \(host), \(port)")
                return "http://\(host):\(port)"
            }
        }

        return ""
    }
}
