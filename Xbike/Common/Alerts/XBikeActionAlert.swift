//
//  XBikeActionAlert.swift
//  Xbike
//
//  Created by Alberto Ortiz on 30/05/22.
//

import UIKit

class XbikeActionAlert: UIView {
    struct Constants {
        static let paddingTop: CGFloat = 60.0
        static let paddingSides: CGFloat = 15.0
        static let paddingButton: CGFloat = 10.0
        static let paddingButtonBottom: CGFloat = 15.0
        static let paddingButtonSides: CGFloat = 60.0
        static let separatorWidth: CGFloat = 2.0
    }
    
    private let message: NSAttributedString
    private let onCompleted: () -> Void
    private let onCancelled: () -> Void
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("DELETE", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.buttonFont
        return button
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("STORE", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.buttonFont
        return button
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        self.message = NSAttributedString("")
        self.onCompleted = {}
        self.onCancelled = {}
        super.init(frame: frame)
        setupViews()
    }
    
    init(message: NSAttributedString, onPressed: @escaping () -> Void, onCancelled: @escaping () -> Void) {
        self.message = message
        self.onCompleted = onPressed
        self.onCancelled = onCancelled
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.addDropShadow()
        self.roundCorners()
        
        self.messageLabel.attributedText = self.message
        cancelButton.addTarget(self, action: #selector(self.pressedCancel(_:)), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(self.pressedOk(_:)), for: .touchUpInside)
        self.addSubview(messageLabel)
        self.addSubview(cancelButton)
        self.addSubview(okButton)
        self.addSubview(separator)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: XbikeActionAlert.Constants.paddingTop),
            messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: XbikeActionAlert.Constants.paddingButton),
            cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -XbikeActionAlert.Constants.paddingButtonBottom),
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -XbikeActionAlert.Constants.paddingButtonSides),
            
            okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: XbikeActionAlert.Constants.paddingButton),
            okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -XbikeActionAlert.Constants.paddingButtonBottom),
            okButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: XbikeActionAlert.Constants.paddingButtonSides),
            
            separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            separator.widthAnchor.constraint(equalToConstant: XbikeActionAlert.Constants.separatorWidth),
            separator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separator.centerYAnchor.constraint(equalTo: okButton.centerYAnchor)
        ])
    }

    @objc func pressedOk(_ sender: UIButton) {
        onCompleted()
        self.dismissAlert()
    }
    
    @objc func pressedCancel(_ sender: UIButton) {
        onCancelled()
        self.dismissAlert()
    }
    
    func dismissAlert() {
        self.removeFromSuperview()
    }
}
