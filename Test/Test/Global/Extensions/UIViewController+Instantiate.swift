//
//  UIViewController+Instantiate.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiateFromStoryboard(_ name: String = "Main", _ identifier: String? = nil) -> Self {
        func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
            let storyboard = UIStoryboard(name: name, bundle: nil)
            let id = identifier ?? String(describing: self)
            let controller = storyboard.instantiateViewController(withIdentifier: id) as! T
            return controller
        }
        return instantiateFromStoryboardHelper(name)
    }
}
