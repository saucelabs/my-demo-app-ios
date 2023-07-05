//
//  PushNotificationsViewController.swift
//  My Demo App
//

import UIKit
import UserNotifications

class PushNotificationsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class PushNotificationsLoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let progress = UIActivityIndicatorView(style: .large)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.startAnimating()
        
        addSubview(progress)
        NSLayoutConstraint.activate([
            progress.centerXAnchor.constraint(equalTo: centerXAnchor),
            progress.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

class PushNotificationsButtonView: UIView {
    var action: (() -> Void)?
    
    var buttonText: String? {
        get {
            button.title(for: .normal)
        }
        set {
            button.setTitle(newValue, for: .normal)
        }
    }
    
    var labelText: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }
    
    let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0

        return view
    }()

    let button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "GreenButton Icons"), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Register for Push Notifications", for: .normal)

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(button)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])

        label.text = ""
        button.addTarget(self, action: #selector(runAction), for: .touchUpInside)
    }
    
    @objc func runAction() {
        action?()
    }
}

class PushNotificationsLabelView: UIView {
    let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])

        label.text = ""
    }
}

class PushNotificationsViewController: UIViewController {
    private let progressView = PushNotificationsLoadingView()
    private let labelView = PushNotificationsLabelView()
    private let buttonView = PushNotificationsButtonView()
    
    @IBOutlet weak var contentView: PushNotificationsView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.registerSuccess(notification:)),
            name: Notification.Name("RegisterForRemoteNotificationsWithDeviceToken"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.registerFailed(notification:)),
            name: Notification.Name("RegisterForRemoteNotificationsWithError"),
            object: nil
        )
        
        buttonView.action = {
            self.registerForPushNotifications { status in
                if status == .authorized {
                    self.fill(view: self.progressView)
                    UIApplication.shared.registerForRemoteNotifications()
                } else if status == .denied {
                    self.labelView.label.text = "Push notifications have been disabled for this app. To renable them, go to settings and enable notifications."
                    self.fill(view: self.labelView)
                }
            }
        }
        
        self.fill(view: progressView)
        self.getNotificationSettings { status in
            if status == .denied {
                self.labelView.label.text = "Push notifications have been disabled for this app. To renable them, go to settings and enable notifications."
                self.fill(view: self.labelView)
            } else {
                self.buttonView.labelText = "Click the button below to enabled push notifications. The current status of notifications for this app is '\(self.statusToString(status))\'"
                self.buttonView.buttonText = "Register for Push Notifications"
                self.fill(view: self.buttonView)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        buttonView.action = nil
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func registerSuccess(notification: Notification) {
        if let token = notification.userInfo?["token"] as? String {
            buttonView.labelText = "Successfully registred device with Apple APN with the following token:\n\n\(token)"
            buttonView.buttonText = "Click to Share token"
            buttonView.action = {
                let share = UIActivityViewController(
                    activityItems: [token],
                    applicationActivities: nil
                )
                self.present(share, animated: true, completion: nil)
            }
            self.fill(view: buttonView)
        } else {
            labelView.label.text = "Successfully registred device with Apple APN, but token is unknown"
            self.fill(view: labelView)
        }
    }
    
    @objc func registerFailed(notification: Notification) {
        let data = notification.userInfo?["error"] as? Error
        let message = data?.localizedDescription ?? "Failed registration, with no error"
        buttonView.labelText = message
        buttonView.buttonText = "Try Again"
        self.fill(view: buttonView)
    }
    
    private func fill(view: UIView) {
        contentView.subviews.forEach{ $0.removeFromSuperview() }
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    
    func registerForPushNotifications(_ callback: ((UNAuthorizationStatus) -> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { [weak self] granted, _ in
            TestFairyWrapper.log("Permission granted: \(granted)")
            self?.getNotificationSettings(callback)
        }
    }
    
    func getNotificationSettings(_ callback: ((UNAuthorizationStatus) -> Void)? = nil) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            TestFairyWrapper.log("Notification settings: \(settings)")
            
            DispatchQueue.main.async {
                callback?(settings.authorizationStatus)
            }
        }
    }
    
    private func statusToString(_ status: UNAuthorizationStatus) -> String {
        switch status {
        case .notDetermined:
            return "not determined"
        case .denied:
            return "denied"
        case .authorized:
            return "authorized"
        case .provisional:
            return "provisional"
        case .ephemeral:
            return "ephemeral"
        @unknown default:
            fatalError("Failed to convert UNAuthorizationStatus \(status.rawValue) to string")
        }
    }
}
