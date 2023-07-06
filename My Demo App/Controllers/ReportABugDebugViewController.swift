//
//  ReportABugDebugViewController.swift
//  My Demo App
//

import UIKit

class ReportABugDebugItemView: UIView {
    let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = UIFont(name: "Courier", size: 12)
        
        return view
    }()
    
    let button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "GreenButton Icons"), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitle("REPORT A BUG", for: .normal)
        
        return view
    }()
    
    var action: (() -> Void)?

    init(_ text: String, action: (() -> Void)?) {
        super.init(frame: .zero)
        self.setupView()
        self.label.text = text
        self.action = action
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
        
    @objc func runAction() {
        action?()
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.backgroundColor = .systemGray5
        
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = .black
        
        addSubview(view)
        addSubview(button)
        addSubview(border)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
            
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),
            
            button.bottomAnchor.constraint(equalTo: border.topAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            border.heightAnchor.constraint(equalToConstant: 1),
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        button.addTarget(self, action: #selector(runAction), for: .touchUpInside)
    }
}

class ReportABugDebugView: UIScrollView {
    let contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        
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
                
        let spacing: CGFloat = 24
        let padding: CGFloat = 16
        
        contentView.spacing = spacing
        addSubview(contentView)
        
        let contentLayoutGuide = self.contentLayoutGuide
        let frameLayoutGuide = self.frameLayoutGuide
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: padding),
            contentView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -padding),
            contentView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: frameLayoutGuide.widthAnchor, constant: -2 * padding)
        ])
        
        contentView.addArrangedSubview(ReportABugDebugItemView(
"""
// Open feedback form with a screenshot
TestFairy.showFeedbackForm(
  MY_APP_TOKEN,
  takeScreenshot:true
)
"""
        ) {
            TestFairyWrapper.resetFeedbackForm()
            TestFairyWrapper.reportBug(true)
        })
        
        contentView.addArrangedSubview(ReportABugDebugItemView(
"""
// Open feedback form without a screenshot
TestFairy.showFeedbackForm(
  MY_APP_TOKEN,
  takeScreenshot:false
)
"""
        ) {
            TestFairyWrapper.resetFeedbackForm()
            TestFairyWrapper.reportBug(false)
        })
        
        contentView.addArrangedSubview(ReportABugDebugItemView(
"""
// Remote Support: Stop session if exists and
// allow user to start video recording
TestFairy.stop();
TestFairy.showFeedbackForm(
  MY_APP_TOKEN,
  takeScreenshot:false
)
"""
        ) {
            TestFairyWrapper.resetFeedbackForm()
            TestFairyWrapper.remoteSupport()
        })
        
        contentView.addArrangedSubview(ReportABugDebugItemView(
"""
// Open feedback form with custom fields
TestFairy.setTestFairyFeedbackOptions(
  TestFairyFeedbackOptions.create { builder in
    builder?.feedbackFormFields = [/* fields */]
  }
);
TestFairy.showFeedbackForm()
"""
        ) {
            TestFairyWrapper.resetFeedbackForm()
            TestFairyWrapper.customFeedback()
        })
    }
}

class ReportABugDebugViewController: UIViewController {
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
