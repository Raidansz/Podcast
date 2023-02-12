//
//  CustomTabItem.swift
//  CustomTabBarExample
//
//  Created by Raidan Shugaa Addin on 2023. 01. 23..
//

import UIKit

enum CustomTabBarItem: String, CaseIterable {
    case profile
    case search
    case favorite
}

 
extension CustomTabBarItem {
    var viewController: UIViewController {
        switch self {
        case .profile:
            return UINavigationController(rootViewController: HomeViewController())
    
        case .search:
            return UINavigationController(rootViewController: PodcastsSearchController())
        case .favorite:
            return UINavigationController(rootViewController: UIViewController())
        }
        
        }
    
    var icon: UIImage? {
        switch self {
        case .search:
            return UIImage(systemName: "magnifyingglass.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .favorite:
            return UIImage(systemName: "heart.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .profile:
            return UIImage(systemName: "house.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .search:
            return UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .favorite:
            return UIImage(systemName: "heart.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .profile:
            return UIImage(systemName: "house.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
}

