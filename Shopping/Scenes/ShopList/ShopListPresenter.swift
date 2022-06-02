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
}

final class ShopListPresenter: NSObject {
    private weak var viewController: ShopListProtocol?
    
    init(viewController: ShopListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
}

extension ShopListPresenter: UISearchBarDelegate {
    
}
