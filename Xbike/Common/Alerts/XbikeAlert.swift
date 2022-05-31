//
//  XbikeAlert.swift
//  Xbike
//
//  Created by Alberto Ortiz on 30/05/22.
//

import UIKit


class XbikeAlert {
    static func showSimpleAlert(with message: String, on viewController: UIViewController) {
        guard let targetView = viewController.view else {
            return
        }
        let alertView = XbikeSimpleAlert(message: message)
        self.setupAlert(alertView, on: targetView)
    }
    
    static func showAlertWithButtons(with message: NSAttributedString, on viewController: UIViewController, onPressed: @escaping () -> Void, onCancelled: @escaping () -> Void) {
        guard let targetView = viewController.view else {
            return
        }
        
        let alertView = XbikeActionAlert(message: message, onPressed: onPressed, onCancelled: onCancelled)
        self.setupAlert(alertView, on: targetView)
    }
    
    private static func setupAlert(_ alert: UIView, on target: UIView) {
        target.addSubview(alert)
        NSLayoutConstraint.activate([
            alert.centerXAnchor.constraint(equalTo: target.centerXAnchor),
            alert.centerYAnchor.constraint(equalTo: target.centerYAnchor),
            alert.widthAnchor.constraint(equalTo: target.widthAnchor, multiplier: 0.8)
        ])
    }
}

