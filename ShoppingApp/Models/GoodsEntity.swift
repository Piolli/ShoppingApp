//
//  GoodsEntity.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 09.01.2021.
//

import Foundation

protocol GoodsTypeConvertible {
    associatedtype GoodsType: CartTypeRepresentable
    
    func asGoods() -> GoodsType
}

protocol CartTypeRepresentable {
    associatedtype CartType: GoodsTypeConvertible

    var quantity: Int { get }
    
    func asCart() -> CartType
    mutating func setQuantity(_ value: Int)
}

struct GoodsEntity {
    let id: Int
    let iconName: String
    let name: String
    let price: Float
}

extension GoodsEntity: GoodsTypeConvertible {
    func asGoods() -> CartGoodsEntity {
        return CartGoodsEntity(id: id, iconName: iconName, name: name, price: price)
    }
}

struct CartGoodsEntity: Encodable {
    private(set) var quantity: Int = 1
    let id: Int
    let iconName: String
    let name: String
    let price: Float
    
    var fullPrice: Float {
        return price * Float(quantity)
    }
    
}

extension CartGoodsEntity: Hashable {
    static func == (lhs: CartGoodsEntity, rhs: CartGoodsEntity) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CartGoodsEntity: Comparable {
    static func < (lhs: CartGoodsEntity, rhs: CartGoodsEntity) -> Bool {
        return lhs.price < rhs.price
    }
}

extension CartGoodsEntity: CartTypeRepresentable {
    mutating func setQuantity(_ value: Int) {
        quantity = value
    }
    
    func asCart() -> GoodsEntity {
        return GoodsEntity(id: id, iconName: iconName, name: name, price: price)
    }
}

