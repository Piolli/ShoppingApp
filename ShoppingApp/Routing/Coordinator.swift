//
//  Coordinator.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 09.01.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    var rootViewController: UIViewController { get }
}
