//
//  ShopWebViewController.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/03.
//

import WebKit
import UIKit
import SnapKit

final class ShopWebViewController: UIViewController {
    private let shop: Shop
    
    private let webView = WKWebView()
    
    private let rightBatButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapBarButtonItem)
    )
    
    init(shop: Shop) {
        self.shop = shop
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupWebView()
    }
}

private extension ShopWebViewController {
    func setupNavigationBar() {
        navigationItem.title = shop.title.htmlToString
        navigationItem.rightBarButtonItem = rightBatButtonItem
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: shop.link.replacingOccurrences(of: "search.shopping.naver.com/gate.nhn?id=", with: "msearch.shopping.naver.com/product/")) else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
        
        let urlRequest = URLRequest(url: linkURL)
       
        webView.load(urlRequest)
    }
    
    @objc func didTapBarButtonItem() {
        UIPasteboard.general.string = shop.link
    }
}
