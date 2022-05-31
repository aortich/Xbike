//
//  FloatingTimerView.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation
import UIKit

class FloatingTimerView: UIView {
    struct Constants {
        static let top: CGFloat = 10.0
        static let bottom: CGFloat = 10.0
        static let sides: CGFloat = 80.0
        static let separatorWidth: CGFloat = 2.0
    }
    
    private lazy var timer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.stopwatchFont
        label.text = "00:00:00"
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.buttonFont
        return button
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("STOP", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.buttonFont
        return button
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var onClickStarted: ((UIButton?) -> ())?
    
    public var onClickedFinish: ((UIButton?) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    func updateTimer(_ elapsed: String) {
        self.timer.text = elapsed
    }
    
    @objc func clickedOnStarted(_ sender: UIButton) {
        onClickStarted?(sender)
    }
    
    @objc func clickedOnFinished(_ sender: UIButton) {
        onClickedFinish?(sender)
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.addDropShadow()
        self.roundCorners()
        
        self.addSubview(timer)
        self.addSubview(startButton)
        self.addSubview(finishButton)
        self.addSubview(separator)
        startButton.addTarget(self, action: #selector(self.clickedOnStarted(_:)), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(self.clickedOnFinished(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            timer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timer.topAnchor.constraint(equalTo: self.topAnchor, constant: FloatingTimerView.Constants.top
                                      ),
            startButton.topAnchor.constraint(equalTo: self.timer.bottomAnchor, constant: FloatingTimerView.Constants.top),
            startButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: FloatingTimerView.Constants.sides),
            startButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -FloatingTimerView.Constants.bottom),
            
            finishButton.topAnchor.constraint(equalTo: self.timer.bottomAnchor, constant: FloatingTimerView.Constants.top),
            finishButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -FloatingTimerView.Constants.sides),
            finishButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -FloatingTimerView.Constants.bottom),
            
            separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            separator.widthAnchor.constraint(equalToConstant: FloatingTimerView.Constants.separatorWidth),
            separator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separator.centerYAnchor.constraint(equalTo: finishButton.centerYAnchor)
        ])
    }
    
    
}
