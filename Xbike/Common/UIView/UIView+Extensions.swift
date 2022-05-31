//
//  UIView+Extensions.swift
//  Xbike
//
//  Created by Alberto Ortiz on 30/05/22.
//

import UIKit

extension UIView {
    func addDropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.40
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
    }
    
    func roundCorners() {
        self.layer.cornerRadius = 12
    }
}
