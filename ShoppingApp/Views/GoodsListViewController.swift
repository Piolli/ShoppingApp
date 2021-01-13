//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 09.01.2021.
//

import UIKit
import SnapKit

class GoodsListViewController: UIViewController {
    
    enum LayoutMetrics {
        static let cartButtonSize = CGSize(width: 64, height: 64)
    }

    private var cartButton: CartButton!
    private let tableView = UITableView()
    
    var viewModel: GoodsListViewModel! {
        didSet {
            viewModel.delegate = self
            viewModel.loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpCartButton()
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: LayoutMetrics.cartButtonSize.height + LayoutMetrics.cartButtonSize.height/2, right: 0)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(GoodsCellView.self, forCellReuseIdentifier: GoodsCellView.identifier)
        tableView.dataSource = self
    }
    
    func setUpCartButton() {
        let cartButtonSize = LayoutMetrics.cartButtonSize
        cartButton = CartButton(frame: .init(x: 0, y: 0, width: cartButtonSize.width, height: cartButtonSize.height))
        cartButton.addTarget(self, action: #selector(goToCartButtonWasTapped), for: .touchUpInside)
        view.addSubview(cartButton)
        cartButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-cartButtonSize.height/2)
            make.height.equalTo(cartButtonSize.height)
            make.width.equalTo(cartButtonSize.width)
        }
    }
    
    @objc func goToCartButtonWasTapped(_ sender: UIButton) {
        viewModel.openCart()
    }
    
}

// MARK: - GoodsListViewModelDelegate
// Another approach is to using Bindable class (aka Observable)
extension GoodsListViewController: GoodsListViewModelDelegate {
    func quantityWasChanged(_ value: Int) {
        cartButton.setQuantityValue(value)
    }
    
    func didLoadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension GoodsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.goodsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsCellView.identifier, for: indexPath) as! GoodsCellView
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        return cell
    }
}
