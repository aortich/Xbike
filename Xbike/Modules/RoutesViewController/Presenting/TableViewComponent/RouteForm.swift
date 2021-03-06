//
//  RouteForm.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import UIKit

class RouteForm: UIView {
    private struct Constants {
        static let marginSides: CGFloat = 10.0
        static let innerTopMargin: CGFloat = 10.0
        static let topBottomMargin: CGFloat = 20.0
        static let bottomMargin: CGFloat = 8.0
    }
    
    public var viewModel: RouteCell.ViewModel? {
        didSet {
            didUpdateModel()
        }
    }
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.stopwatchListFont
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.navbarTitleFont
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(timeLabel)
        self.addSubview(distanceLabel)
 
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: RouteForm.Constants.marginSides),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -RouteForm.Constants.topBottomMargin),
            
            distanceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -RouteForm.Constants.topBottomMargin),
            distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -RouteForm.Constants.marginSides)
        ])
    }
    
    private func didUpdateModel() {
        guard let model = self.viewModel else { return }
        self.timeLabel.text = model.time
        self.distanceLabel.text = model.distance
    }
    

}
