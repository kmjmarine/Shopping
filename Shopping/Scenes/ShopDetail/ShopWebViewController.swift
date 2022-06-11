//
//  ShopWebViewController.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/03.
//

import WebKit
import UIKit

final class ShopWebViewController: UIViewController {
    private var presenter: ShopWebViewPresenter!
    
    private let webView = WKWebView()
    
    private lazy var rightBatButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "star"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    init(shop: Shop) {
        super.init(nibName: nil, bundle: nil)
        
        presenter = ShopWebViewPresenter(viewController: self, shop: shop)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension ShopWebViewController: ShopWebViewProtocol {
    func setupNavigationBar(with title: String) {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = title.htmlToString
        navigationItem.rightBarButtonItem = rightBatButtonItem
    }
    
    func setupWebView(with link: String) {
        guard let linkURL = URL(string: link.replacingOccurrences(of: "search.shopping.naver.com/gate.nhn?id=", with: "msearch.shopping.naver.com/product/")) else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
        
        let urlRequest = URLRequest(url: linkURL)
       
        webView.load(urlRequest)
    }
    
    func setRigthBarButton(with isLiked: Bool) {
        let imageName = isLiked ? "star.fill" : "star"
        rightBatButtonItem.image = UIImage(systemName: imageName)
    }
}

extension ShopWebViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}
