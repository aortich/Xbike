//
//  OnboardingSubscreenController.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import UIKit

class OnboardingSubscreenController: UIViewController {
    struct Constants {
        static let paddingImage: CGFloat = 15.0
    }
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.stopwatchFont
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.setupView()
    }
    
    func setupView() {
        self.view.addSubview(label)
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: OnboardingSubscreenController.Constants.paddingImage),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
        ])
    }
    
    func updateText(_ string: String) {
        self.label.text = string
    }
    
    func updateImage(_ image: UIImage) {
        self.imageView.image = image
    }
 }
