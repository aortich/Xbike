//
//  OnboardingSubscreenController.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import UIKit

class OnboardingSubscreenController: UIViewController {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.setupView()
    }
    
    func setupView() {
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
        ])
    }
    
    func updateText(_ string: String) {
        self.label.text = string
    }
}
