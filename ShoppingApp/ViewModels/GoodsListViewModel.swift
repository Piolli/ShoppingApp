//
//  GoodsListViewModel.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 09.01.2021.
//

import Foundation

protocol GoodsListViewModelDelegate: class {
    func didLoadData()
    func quantityWasChanged(_ value: Int)
}

class GoodsListViewModel {
    
    private unowned let coordinator: GoodsListCoordinator
    private let dataProvider: GoodsDataProvider
    private var goodsCellViewModels: [GoodsCellViewModel] = []
    private var userCart = Set<CartGoodsEntity>() {
        didSet {
            self.updateQuantity()
        }
    }
    weak var delegate: GoodsListViewModelDelegate?
    
    var goodsCount: Int {
        return goodsCellViewModels.count
    }
    
    init(coordinator: GoodsListCoordinator, dataProvider: GoodsDataProvider = SampleGoodsDataProvider()) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
    }
    
    func cellViewModel(for indexPath: IndexPath) -> GoodsCellViewModel {
        return goodsCellViewModels[indexPath.row]
    }
    
    func loadData() {
        dataProvider.fetchGoods { [weak self] (goodsList) in
            guard let self = self else {
                return
            }
            self.goodsCellViewModels = goodsList.map {
                var cellViewModel = GoodsCellViewModel(goodsEntity: $0)
                cellViewModel.wasAddedToCart = { goodsEntity in
                    let (wasAdded, _) = self.userCart.insert(goodsEntity.asGoods())
                    if wasAdded {
                        self.updateQuantity()
                    }
                }
                return cellViewModel
            }
            self.delegate?.didLoadData()
        }
    }
    
    func openCart() {
        coordinator.openCart(with: Array(userCart).sorted(by: >))
    }
    
    func updateCart(_ items: [CartGoodsEntity]) {
        userCart = Set(items)
        delegate?.didLoadData()
    }
    
    func updateQuantity() {
        self.delegate?.quantityWasChanged(userCart.count)
    }
    
}

struct GoodsCellViewModel {
    
    let goodsEntity: GoodsEntity
    var wasAddedToCart: ((GoodsEntity) -> Void)?
    
    var name: String {
        return "\(goodsEntity.name)"
    }
    
    var iconName: String {
        return goodsEntity.iconName
    }
    
    var price: String {
        return goodsEntity.price.formatToCurrency()
    }
    
    func addToCart() {
        wasAddedToCart?(goodsEntity)
    }
    
}
