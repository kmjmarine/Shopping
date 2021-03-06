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
        
        tableView.register(
            ShopListTableViewCell.self,
            forCellReuseIdentifier: ShopListTableViewCell.identifier)
        
        return tableView
    }()
    
    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        tableView.register(
            ShopListTableViewCell.self,
            forCellReuseIdentifier: ShopListTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tag = 1
        searchResultTableView.tag = 2
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
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
        searchController.searchBar.placeholder = "또 사제껴?"
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
    
    func pushToShopViewContoller(with shop: Shop) {
        let shopWebViewController = ShopWebViewController(shop: shop)
        navigationController?.pushViewController(shopWebViewController, animated: true)
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadSearchTableView() {
        searchResultTableView.reloadData()
    }
}

private extension ShopListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
}
