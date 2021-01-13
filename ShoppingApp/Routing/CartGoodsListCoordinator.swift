//
//  CartGoodsListCoordinator.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import UIKit

class CartGoodsListCoordinator: NSObject, Coordinator {
    
    private var cartGoodsListViewController: CartGoodsListViewController!
    private var cartItems: [CartGoodsEntity]

    private unowned let goodsListCoordinator: GoodsListCoordinator
    private unowned var navigationController: UINavigationController!
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(goodsListCoordinator: GoodsListCoordinator, navigationController: UINavigationController, cartItems: [CartGoodsEntity]) {
        self.goodsListCoordinator = goodsListCoordinator
        self.navigationController = navigationController
        self.cartItems = cartItems
        cartGoodsListViewController = CartGoodsListViewController()
    }
    
    func start() {
        cartGoodsListViewController.view.backgroundColor = .white
        cartGoodsListViewController.navigationItem.title = "Корзина"

        let viewModel = CartGoodsListViewModel(coordinator: self, userCart: cartItems)
        viewModel.userCartWasChanged = { [unowned self] newCart in
            self.goodsListCoordinator.updateUserCart(newCart)
        }
        cartGoodsListViewController.viewModel = viewModel
        
        navigationController.pushViewController(cartGoodsListViewController, animated: true)
    }
    
}
