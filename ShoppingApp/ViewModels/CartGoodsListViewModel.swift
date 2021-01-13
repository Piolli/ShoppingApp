//
//  CartGoodsListViewModel.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 10.01.2021.
//

import Foundation

protocol CartGoodsListViewModelDelegate: class {
    func totalCostWasCalculated(text: String)
    func didLoadData()
}

class CartGoodsListViewModel {
    
    private unowned let coordinator: CartGoodsListCoordinator
    private let dataProvider: GoodsDataProvider
    private var cartGoodsCellViewModels: [CartGoodsCellViewModel] = []
    
    weak var delegate: CartGoodsListViewModelDelegate?
    
    var userCartWasChanged: (([CartGoodsEntity]) -> Void)?
    
    var cartGoodsCount: Int {
        return cartGoodsCellViewModels.count
    }
    
    var cartToJSON: String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        if let data = try? jsonEncoder.encode(cartGoodsCellViewModels.map(\.cartGoodsEntity)) {
            return String(data: data, encoding: .utf8) ?? ""
        }
        return ""
    }
    
    init(coordinator: CartGoodsListCoordinator, userCart: [CartGoodsEntity], dataProvider: GoodsDataProvider = SampleGoodsDataProvider()) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        
        cartGoodsCellViewModels = userCart.map { (cartGoodsEntity) in
            return CartGoodsCellViewModel(cartGoodsEntity: cartGoodsEntity) { [weak self] _ in
                self?.removeCartGoods(with: cartGoodsEntity.id)
                self?.delegate?.didLoadData()
                self?.updateCart()
            } quantityValueWasChanged: { [weak self] (newValue) in
                self?.updateQuantityValue(with: cartGoodsEntity.id, newValue)
                self?.updateCart()
            }
        }
    }
    
    func removeCartGoods(with id: Int) {
        cartGoodsCellViewModels.removeAll { (viewModel) -> Bool in
            viewModel.cartGoodsEntity.id == id
        }
    }
    
    func updateQuantityValue(with id: Int, _ value: Int) {
        let indexCartViewModels = self.cartGoodsCellViewModels.firstIndex {
            $0.cartGoodsEntity.id == id
        }!
        self.cartGoodsCellViewModels[indexCartViewModels].cartGoodsEntity.setQuantity(value)
    }
    
    func updateCart() {
        self.userCartWasChanged?(self.cartGoodsCellViewModels.map(\.cartGoodsEntity))
        self.calculateTotalCost()
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CartGoodsCellViewModel {
        return cartGoodsCellViewModels[indexPath.row]
    }
    
    func loadData() {
        calculateTotalCost()
        delegate?.didLoadData()
    }
    
    func calculateTotalCost() {
        let totalCost = cartGoodsCellViewModels.reduce(0) { (initial, cartGoods) -> Float in
            initial + cartGoods.cartGoodsEntity.fullPrice
        }
        delegate?.totalCostWasCalculated(text: "Общая сумма:\n \(totalCost.formatToCurrency())")
    }
    
}

struct CartGoodsCellViewModel {
    
    var cartGoodsEntity: CartGoodsEntity
    var wasRemovedFromCart: ((CartGoodsEntity) -> Void)?
    var quantityValueWasChanged: ((Int) -> Void)?
    
    var name: String {
        return "\(cartGoodsEntity.name)"
    }
    
    var iconName: String {
        return cartGoodsEntity.iconName
    }
    
    var price: String {
        return cartGoodsEntity.price.formatToCurrency()
    }
    
    func removeFromCart() {
        wasRemovedFromCart?(cartGoodsEntity)
    }
    
    func setQuantityValue(_ value: Int) {
        if value == 0 {
            removeFromCart()
        } else {
            quantityValueWasChanged?(value)
        }
    }
    
}
