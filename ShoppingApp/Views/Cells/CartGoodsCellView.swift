//
//  CartGoodsCellView.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import SnapKit
import UIKit

class CartGoodsCellView: UITableViewCell {
    
    static let identifier = String(describing: GoodsCellView.self)
    var viewModel: CartGoodsCellViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title3)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        return view
    }()
    
    lazy var quantityView: QuantityView = {
        let view = QuantityView()
        //add delegate (or closure)
        view.quantityValueWasChanged = { [unowned self] value in
            self.viewModel.setQuantityValue(value)
        }
        return view
    }()
    
    lazy var removeFromCartButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.setTitle("Удалить из корзины", for: .normal)
        view.addTarget(self, action: #selector(removeFromCartButtonWasTapped), for: .touchUpInside)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        contentView.addSubview(iconImageView)

        iconImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(64)
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }
        
        let vStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel, removeFromCartButton, quantityView])
        vStackView.axis = .vertical
        vStackView.distribution = .equalSpacing
        vStackView.spacing = 12
        contentView.addSubview(vStackView)
        vStackView.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.greaterThanOrEqualTo(iconImageView).priority(999)
        }
    }
    
    func bindViewModel() {
        iconImageView.image = UIImage(named: viewModel.iconName)
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        quantityView.setQuantityValue(viewModel.cartGoodsEntity.quantity)
    }
    
    @objc private func removeFromCartButtonWasTapped(_ sender: UIButton) {
        viewModel.removeFromCart()
    }
    
}
