//
//  CartButton.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import SnapKit
import UIKit

class CartButton: UIButton {
    
    enum LayoutMetrics {
        static let quantitySize = CGSize(width: 32, height: 32)
    }
    
    private var quantity = 0
    
    private lazy var quantityLabel: UILabel = {
        let view = UILabel(frame: .init(x: 0, y: 0, width: LayoutMetrics.quantitySize.width, height: LayoutMetrics.quantitySize.height))
        view.text = "0"
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        setUpButtonAppearance()
        setUpQuantityLabel()
    }
    
    private func setUpButtonAppearance() {
        backgroundColor = .green
        layer.cornerRadius = min(frame.height, frame.width) / 2
        setImage(UIImage(named: "shopping-cart-empty-side-view_2"), for: .normal)
    }
    
    private func setUpQuantityLabel() {
        addSubview(quantityLabel)
        quantityLabel.layer.cornerRadius = min(LayoutMetrics.quantitySize.width, LayoutMetrics.quantitySize.height) / 2
        quantityLabel.layer.masksToBounds = true
        quantityLabel.backgroundColor = .red
        quantityLabel.textColor = .white
        quantityLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(-8)
            make.width.equalTo(LayoutMetrics.quantitySize.width)
            make.height.equalTo(LayoutMetrics.quantitySize.height)
        }
    }
    
    func setQuantityValue(_ value: Int) {
        quantityLabel.text = "\(value)"
    }
    
}

