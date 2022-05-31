//
//  RoutesViewControllerPresenter.swift
//  Xbike
//
//  Created by Alberto Ortiz on 29/05/22.
//

import Foundation
import UIKit

public class RoutesViewControllerImpl: UIViewController {
    private let reuseIdentifier: String = "RouteCell"
    var presenter: RoutesPresenter?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public override func viewDidLoad() {
        self.presenter = RoutesPresenter(view: self)
        self.navigationItem.title = "My Progress"
        self.title = "My Progress"
        setupViews()
        setupTableView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    private func setupTableView() {
        self.tableView.register(RouteCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.tableView.dataSource = self
    }
    
    private func setupViews() {
        self.view.backgroundColor = .orange
        self.tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RoutesViewControllerImpl: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.presenter?.getItemAt(indexPath.row) else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as? RouteCell else {
            let cell = RouteCell()
            cell.update(with: viewModel)
            return cell
        }
        
        cell.update(with: viewModel)
        cell.backgroundColor = .white
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getItemCount() ?? 0
    }
}
