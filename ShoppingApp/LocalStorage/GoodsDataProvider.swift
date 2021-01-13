//
//  GoodsDataProvider.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation

protocol GoodsDataProvider {
    func fetchGoods(completion: ([GoodsEntity]) -> Void)
}

class SampleGoodsDataProvider: GoodsDataProvider {
    
    func fetchGoods(completion: ([GoodsEntity]) -> Void) {
        let sampleData: [GoodsEntity] = [
            .init(id: 1, iconName: "food", name: "Очень длинное длинное длинное длинное длинное длинное длинное длинное длинное длинное длинное длинное длинное длинное длинное длинное название", price: 100.0),
            .init(id: 2, iconName: "food", name: "Короткое название", price: 2.0),
            .init(id: 3, iconName: "food", name: "Название", price: 1.50),
        ]
        completion(sampleData)
    }
    
}
