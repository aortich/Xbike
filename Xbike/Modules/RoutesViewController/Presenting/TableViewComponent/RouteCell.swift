//
//  RouteCell.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation
import UIKit

public class RouteCell: UITableViewCell {
    private lazy var formView: RouteForm = {
        let formView = RouteForm()
        formView.translatesAutoresizingMaskIntoConstraints = false
        return formView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not beeen instantiated")
    }
    
    func setupView() {
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(formView)
        selectionStyle = .none
        self.constraintToSuperview()
        backgroundColor = .clear
        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: contentView.topAnchor),
            formView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            formView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func update(with model:RouteCell.ViewModel) {
        self.formView.viewModel = model
    }
    
    private func constraintToSuperview() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}

extension RouteCell {
    public struct ViewModel {
        let time: String
        let distance: String
    }
}
