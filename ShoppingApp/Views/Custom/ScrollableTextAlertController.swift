//
//  ScrollableTextAlertController.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 11.01.2021.
//

import Foundation
import UIKit

class ScrollableTextAlertController: NSObject {
    
    let textView = UITextView(frame: CGRect.zero)

    func create(with text: String) -> UIAlertController {
        textView.text = text
        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: .alert)

        let cancelAction = UIAlertAction.init(title: "Close", style: .default) { (action) in
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(cancelAction)

        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        textView.backgroundColor = UIColor.white
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        alertController.view.addSubview(self.textView)
        return alertController
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                        let margin:CGFloat = 8.0
                textView.frame = CGRect.init(x: rect.origin.x + margin, y: rect.origin.y + margin, width: rect.width - 2*margin, height: rect.height / 1.4)
                textView.bounds = CGRect.init(x: rect.origin.x + margin, y: rect.origin.y + margin, width: rect.width - 2*margin, height: rect.height / 1.4)
            }
        }
    }
    
}
