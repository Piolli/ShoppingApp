//
//  QuantityView.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import UIKit
import SnapKit

class QuantityView: UIView {
    
    var quantityValueWasChanged: ((Int) -> Void)?

    private(set) var quantity: Int = 1
    
    private lazy var quantityLabel: UILabel = {
        let view = UILabel()
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
        let leadingButton = UIButton(type: .roundedRect)
        leadingButton.tag = -1
        leadingButton.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
        leadingButton.setTitle("-", for: .normal)
        
        let trailingButton = UIButton(type: .roundedRect)
        trailingButton.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
        trailingButton.tag = 1
        trailingButton.setTitle("+", for: .normal)
        
        let hStackView = UIStackView(arrangedSubviews: [leadingButton, quantityLabel, trailingButton])
        hStackView.axis = .horizontal
        hStackView.distribution = .equalSpacing
        hStackView.spacing = 16
        hStackView.alignment = .center
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        quantityLabel.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(50)
        }
        
        updateQuantityLabel()
    }
    
    
    func updateQuantityLabel() {
        quantityLabel.text = "\(quantity)"
    }
    
    @objc func buttonWasTapped(_ sender: UIButton) {
        let diff = sender.tag
        let newQuantity = max(quantity + diff, 0)
        setQuantityValue(newQuantity)
    }
    
    func setQuantityValue(_ value: Int) {
        quantity = value
        quantityValueWasChanged?(quantity)
        updateQuantityLabel()
    }
    
}
