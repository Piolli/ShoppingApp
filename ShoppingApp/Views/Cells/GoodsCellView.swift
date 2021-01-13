//
//  GoodsCellView.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import UIKit
import SnapKit

class GoodsCellView: UITableViewCell {
    
    static let identifier = String(describing: GoodsCellView.self)
    var viewModel: GoodsCellViewModel! {
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
    
    lazy var addToCartButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.setTitle("Добавить в корзину", for: .normal)
        view.addTarget(self, action: #selector(addToCartButtonWasTapped), for: .touchUpInside)
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
        
        let vStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel, addToCartButton])
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
    
    private func bindViewModel() {
        iconImageView.image = UIImage(named: viewModel.iconName)
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
    }
    
    @objc private func addToCartButtonWasTapped(_ sender: UIButton) {
        viewModel.addToCart()
    }
    
}
