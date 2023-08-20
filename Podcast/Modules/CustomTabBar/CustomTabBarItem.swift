//
//  CustomTabItem.swift
//  CustomTabBarExample
//
//  Created by Raidan Shugaa Addin on 2023. 01. 23..
//

import UIKit

enum CustomTabBarItem: String, CaseIterable {
    case profile
    case play
    case search
    case favorite
}

 
extension CustomTabBarItem {
    var viewController: UIViewController {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        switch self {
    
        case .profile:
            return UINavigationController(rootViewController: HomeViewController())
        case .play:

        
            let customView = appDelegate.playerDetailsViewREF
            
            if let safe =  customView {
                print("goooood")
            }else {
                print("BAAAAAAAD")
            }
            let viewC = UIViewController()
            viewC.view.backgroundColor = UIColor.green

//
//            // Set the frame to cover the entire screen
//             customView.frame = UIScreen.main.bounds
//
//            // Add the custom view as a subview to the parent view controller's view
//            if let customView = customView {
//                viewC.view.addSubview(customView)
//            }else{
//                return UINavigationController(rootViewController: UIViewController())
//            }
            
            return UINavigationController(rootViewController: viewC)
                    
        case .search:
            return UINavigationController(rootViewController: PodcastsSearchController())
        case .favorite:
            return UINavigationController(rootViewController: UIViewController())
        }
        
        }
    
    var icon: UIImage? {
        switch self {
        case .play:
            return UIImage(systemName: "play.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
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
        case .play:
            return UIImage(systemName: "play.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
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

