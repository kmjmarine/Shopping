//
//  ShopListPresenter.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/01.
//

import UIKit

protocol ShopListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func endRefreshing()
    func reloadTableView()
}

final class ShopListPresenter: NSObject {
    private weak var viewController: ShopListProtocol?
    private let shopSearchManager: ShopSearchManagerProtocol
    
    private var currentKeyword = "이어폰"
    private var currentPage: Int = 0
    private let displayCount: Int = 20
    
    private var shopList: [Shop] = [ ]
    
    init(viewController: ShopListProtocol, shopSearchManager: ShopSearchManagerProtocol = ShopSearchManager()) {
        self.viewController = viewController
        self.shopSearchManager = shopSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
    
    func didCalledRefresh() {
        requestShopList(isNeededReset: true)
    }
}

extension ShopListPresenter: UISearchBarDelegate {
    
}

extension ShopListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shop = shopList[indexPath.row]
        /***
         게시글 탭시 이동
         ***/
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        
        guard (currentRow % 20) == displayCount - 3 && (currentRow / displayCount) == (currentPage - 1)
        else {
            return
        }
        
        requestShopList(isNeededReset: false)
    }
}

extension ShopListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopListTableViewCell.identifier, for: indexPath) as? ShopListTableViewCell
        
        let shop = shopList[indexPath.row]
        cell?.setup(shop: shop)
        
        return UITableViewCell()
    }
}

private extension ShopListPresenter {
    func requestShopList(isNeededReset: Bool) {
        if isNeededReset {
            currentPage = 0
            shopList = [ ]
        }
        shopSearchManager.request(from: currentKeyword, start: (currentPage * displayCount) + 1, display: displayCount) { [weak self] newValue in
            self?.shopList += newValue
            self?.currentPage += 1
            self?.viewController?.reloadTableView()
            self?.viewController?.endRefreshing()
        }
    }
}
