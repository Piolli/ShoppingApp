//
//  GoodsListCoordinator.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import UIKit

class GoodsListCoordinator: Coordinator {
    
    private var goodsListViewController: GoodsListViewController!
    private var cartGoodsListCoordinator: CartGoodsListCoordinator!
    private unowned var navigationController: UINavigationController!
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        goodsListViewController = GoodsListViewController()
    }
    
    func start() {
        goodsListViewController.view.backgroundColor = .white
        goodsListViewController.navigationItem.title = "Список товаров"
        
        goodsListViewController.viewModel = GoodsListViewModel(coordinator: self)
        navigationController.pushViewController(goodsListViewController, animated: true)
    }
    
    func openCart(with items: [CartGoodsEntity]) {
        cartGoodsListCoordinator = CartGoodsListCoordinator(goodsListCoordinator: self, navigationController: navigationController, cartItems: items)
        cartGoodsListCoordinator.start()
    }
    
    func updateUserCart(_ userCart: [CartGoodsEntity]) {
        goodsListViewController.viewModel.updateCart(userCart)
    }
    
}
