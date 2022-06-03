//
//  ShopListViewController.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/01.
//

import UIKit
import SnapKit

final class ShopListViewController: UIViewController {
    private lazy var presenter = ShopListPresenter(viewController: self)
    
    private lazy var searchController = UISearchController()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        tableView.register(ShopListTableViewCell.self, forCellReuseIdentifier: ShopListTableViewCell.identifier)
        
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        ShopSearchManager()
            .request(from: "노트북", start: 1, display: 20) { shopArray in
                print(shopArray)
            }
    }
}

extension ShopListViewController: ShopListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "Shopping"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
    }
    
    func setupViews() {
        [tableView, searchResultTableView]
            .forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchResultTableView.isHidden = true
    }
    
    func updateSearchTableView(isHidden: Bool) {
        searchResultTableView.isHidden = isHidden
        searchResultTableView.reloadData()
    }
    
    func pushToShopViewController(with shop: Shop) {
        //let shopDetailViewController
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

private extension ShopListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
}
