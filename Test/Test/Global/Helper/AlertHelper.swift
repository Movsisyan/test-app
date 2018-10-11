//
//  AlertHelper.swift
//  Test
//
//  Created by Mher Movsisyan on 10/9/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import UIKit

class AlertHelper {
    static func showAlert(_ message: String, positiveActionTitle: String = Constants.AlertTitles.positive, negativeActionTitle: String? = nil, handler:(()->Void)? = nil) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: positiveActionTitle, style: .default) { (action) in
            handler? ()
        }
        
        alert.addAction(okAction)
        if let negativeTitle = negativeActionTitle {
            let cancelAction = UIAlertAction(title: negativeTitle, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        alert.show()
    }
}

extension UIAlertController {
    
    func show() {
        present(animated: true, completion: nil)
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(controller: rootVC, animated: animated, completion: completion)
        }
    }
    
    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(controller: visibleVC, animated: animated, completion: completion)
        } else {
            if  let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(controller: selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion)
            }
        }
    }
}
