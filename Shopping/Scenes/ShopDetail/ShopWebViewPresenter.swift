//
//  ShopWebViewPresenter.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/11.
//

import Foundation

protocol ShopWebViewProtocol: AnyObject {
    func setRigthBarButton(with isLiked: Bool)
    func setupNavigationBar(with title: String)
    func setupWebView(with link: String)
}

final class ShopWebViewPresenter {
    private weak var viewController: ShopWebViewProtocol?
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var shop: Shop
    
    init(
        viewController: ShopWebViewProtocol,
        shop: Shop,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.shop = shop
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setRigthBarButton(with: shop.isLiked)
        viewController?.setupNavigationBar(with: shop.title)
        viewController?.setupWebView(with: shop.link)
    }
    
    func didTapRightBarButtonItem() {
        shop.isLiked.toggle()
        
        if shop.isLiked {
            userDefaultsManager.addShop(shop)
        } else {
            userDefaultsManager.removeShop(shop)
        }
        
        viewController?.setRigthBarButton(with: shop.isLiked)
    }
}
