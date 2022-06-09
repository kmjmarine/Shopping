//
//  SceneDelegate.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.tintColor = .systemGreen
        window?.rootViewController = UINavigationController(rootViewController: ShopListViewController())
        window?.makeKeyAndVisible()
    }
}

