//
//  TabbarController.swift
//  Crypto
//
//  Created by Necati Alperen IŞIK on 8.05.2024.
//

import UIKit

final class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .systemGray3
        setupTabbar()
    }
    
    private func setupTabbar(){
        let vcFirst  = UINavigationController(rootViewController:CryptoVC())
        let vcSecond = UINavigationController(rootViewController:FavoritesVC())
        vcFirst.tabBarItem.image = UIImage(systemName: "bitcoinsign.circle")
        vcSecond.tabBarItem.image = UIImage(systemName: "heart")
        vcFirst.tabBarItem.title = "Cryptos"
        vcSecond.tabBarItem.title = "Favorites"
        tabBar.tintColor = .label
        setViewControllers([vcFirst,vcSecond], animated: true)
    }
}

