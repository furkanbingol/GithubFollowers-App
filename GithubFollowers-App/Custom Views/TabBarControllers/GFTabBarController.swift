//
//  GFTabBarController.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 14.09.2023.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        if #available(iOS 15, *) {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        self.viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesListVC)
    }

}
