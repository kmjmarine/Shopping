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
    func updateSearchTableView(isHidden: Bool)
    func pushToShopViewContoller(with shop: Shop)
    func endRefreshing()
    func reloadTableView()
}

final class ShopListPresenter: NSObject {
    private weak var viewController: ShopListProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let shopSearchManager: ShopSearchManagerProtocol
    
    private var currentKeyword = "이어폰"
    private var currentPage: Int = 0
    private let displayCount: Int = 20
    
    private var shopList: [Shop] = [ ]
    private var currentShopSearchResult: [Shop] = [ ]
    
    private var likedShop: [Shop] = [ ]
    
    init(
        viewController: ShopListProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        shopSearchManager: ShopSearchManagerProtocol = ShopSearchManager()) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.shopSearchManager = shopSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        likedShop = userDefaultsManager.getShops()
        viewController?.reloadTableView()
    }
    
    func didCalledRefresh() {
        requestShopList(isNeededReset: true)
    }
}

extension ShopListPresenter: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentShopSearchResult = [ ]
        viewController?.updateSearchTableView(isHidden: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentKeyword = searchText
        requestShopList(isNeededReset: true)
    }
}

extension ShopListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shop = currentShopSearchResult[indexPath.row]
        viewController?.pushToShopViewContoller(with: shop)
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
        currentShopSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopListTableViewCell.identifier, for: indexPath) as? ShopListTableViewCell

        let shop = currentShopSearchResult[indexPath.row]
        cell?.setup(shop: shop)

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didselectRowAt indexPath: IndexPath) {
        let shop = currentShopSearchResult[indexPath.item]
        viewController?.pushToShopViewContoller(with: shop)
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
            self?.currentShopSearchResult += newValue
            self?.viewController?.updateSearchTableView(isHidden: false)
            self?.viewController?.reloadTableView()
            self?.viewController?.endRefreshing()
        }
    }
}
