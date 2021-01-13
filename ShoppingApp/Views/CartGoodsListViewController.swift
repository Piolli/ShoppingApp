//
//  CartGoodsListViewController.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 10.01.2021.
//

import UIKit
import SnapKit

class CartGoodsListViewController: UIViewController {
    
    enum LayoutMetrics {
        static let cartButtonSize = CGSize(width: 64, height: 64)
    }

    private let tableView = UITableView()
    private let checkoutView = CheckoutView()
    
    var viewModel: CartGoodsListViewModel! {
        didSet {
            viewModel.delegate = self
            viewModel.loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCheckoutView()
        setUpTableView()
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(checkoutView.snp.top).offset(-16)
            make.left.right.equalToSuperview()
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CartGoodsCellView.self, forCellReuseIdentifier: GoodsCellView.identifier)
        tableView.dataSource = self
    }
    
    func setUpCheckoutView() {
        view.addSubview(checkoutView)
        checkoutView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
        checkoutView.checkoutButtonWasPressed = { [unowned self] in
            let alertController = ScrollableTextAlertController().create(with: viewModel.cartToJSON)
            present(alertController, animated: true, completion: nil)
        }
    }
    
}



// Another approach is to using Bindable class (aka Observable)
extension CartGoodsListViewController: CartGoodsListViewModelDelegate {
    func totalCostWasCalculated(text: String) {
        checkoutView.setTotalCost(text: text)
    }

    func didLoadData() {
        tableView.reloadData()
    }
}

extension CartGoodsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartGoodsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartGoodsCellView.identifier, for: indexPath) as! CartGoodsCellView
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        return cell
    }
}
