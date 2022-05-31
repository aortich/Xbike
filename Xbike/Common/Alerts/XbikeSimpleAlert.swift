//
//  XbikeSimpleAlert.swift
//  Xbike
//
//  Created by Alberto Ortiz on 30/05/22.
//

import UIKit


class XbikeSimpleAlert: UIView {
    struct Constants {
        static let paddingTop: CGFloat = 100.0
        static let paddingSides: CGFloat = 15.0
        static let paddingButton: CGFloat = 30.0
        static let paddingButtonBottom: CGFloat = 15.0
    }
    
    private let message: String
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.navbarTitleFont
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.buttonFont
        return button
    }()
    
    override init(frame: CGRect) {
        self.message = ""
        super.init(frame: frame)
        setupViews()
    }
    
    init(message: String) {
        self.message = message
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    private func setupViews() {
        self.setupBackgroundView()
        self.messageLabel.text = self.message
        cancelButton.addTarget(self, action: #selector(self.dismissAlert(_:)), for: .touchUpInside)
        
        self.addSubview(messageLabel)
        self.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: XbikeSimpleAlert.Constants.paddingTop),
            messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
           
            cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: XbikeSimpleAlert.Constants.paddingButton),
            cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -XbikeSimpleAlert.Constants.paddingButtonBottom),
            cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupBackgroundView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.addDropShadow()
        self.roundCorners()
    }
    
    @objc func dismissAlert(_ sender: UIButton) {
        self.removeFromSuperview()
    }
}
