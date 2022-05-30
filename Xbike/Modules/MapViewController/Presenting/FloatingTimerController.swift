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
        static let sides: CGFloat = 30.0
    }
    
    private lazy var timer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19.0, weight: .light)
        label.text = "00:00:00"
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("STOP", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
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
        self.addSubview(timer)
        self.addSubview(startButton)
        self.addSubview(finishButton)
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
            finishButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -FloatingTimerView.Constants.bottom)
        ])
    }
}
