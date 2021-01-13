//
//  Float + Ext.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation

extension Float {
    func formatToCurrency(locale: Locale = Locale(identifier: "ru_RU")) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        // Currency sets symbol for the value. Server needs to specify it parameter
        formatter.locale = locale
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
