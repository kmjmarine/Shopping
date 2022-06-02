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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
    
//        collectionView.delegate = presenter
//        collectionView.dataSource = presenter
        
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
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
        //searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
    }
    
    func setupViews() {
        [tableView]
            .forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
