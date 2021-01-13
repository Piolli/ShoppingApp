//
//  AppCoordinator.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import UIKit

class AppCoordinator : NSObject, Coordinator {
    
    private let window: UIWindow
    private var navigationController: UINavigationController
    
    private lazy var rootCoordinator: Coordinator = {
        return GoodsListCoordinator(navigationController: navigationController)
    }()
    
    var rootViewController: UIViewController {
        return rootCoordinator.rootViewController
    }
    
    internal init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = rootViewController
        rootCoordinator.start()
        window.makeKeyAndVisible()
    }
    
}
