//
//  CheckoutView.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import UIKit
import SnapKit

class CheckoutView: UIView {
    
    var checkoutButtonWasPressed: (() -> Void)?
    
    private lazy var totalCostLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var checkoutButton: UIButton = {
        let view = UIButton()
        view.setTitle("Сделать заказ", for: .normal)
        view.layer.masksToBounds = true
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        view.contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        view.addTarget(self, action: #selector(checkoutButtonWasPressedTarget), for: .touchUpInside)
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
        let vStackView = UIStackView(arrangedSubviews: [totalCostLabel, checkoutButton])
        vStackView.axis = .vertical
        vStackView.spacing = 16
        addSubview(vStackView)
        vStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setTotalCost(text: String) {
        totalCostLabel.text = text
    }
    
    @objc func checkoutButtonWasPressedTarget(_ sender: UIButton) {
        checkoutButtonWasPressed?()
    }
    
}
