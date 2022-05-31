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
        static let paddingButtonSides: CGFloat = 8.0
    }
    
    private let message: NSAttributedString
    
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
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.buttonFont
        return button
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.buttonFont
        return button
    }()
    
    override init(frame: CGRect) {
        self.message = NSAttributedString("")
        super.init(frame: frame)
        setupViews()
    }
    
    init(message: NSAttributedString) {
        self.message = message
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
        
        self.messageLabel.attributedText = self.message
        self.addSubview(messageLabel)
        self.addSubview(cancelButton)
        self.addSubview(okButton)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: XbikeActionAlert.Constants.paddingTop),
            messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
           
            cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: XbikeActionAlert.Constants.paddingButton),
            cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -XbikeActionAlert.Constants.paddingButtonBottom),
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: XbikeActionAlert.Constants.paddingButtonSides),
            
            okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: XbikeActionAlert.Constants.paddingButton),
            okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -XbikeActionAlert.Constants.paddingButtonBottom),
            okButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: XbikeActionAlert.Constants.paddingButtonSides)
        ])
    }
    
    func dismissAlert() {
        self.removeFromSuperview()
    }
}
