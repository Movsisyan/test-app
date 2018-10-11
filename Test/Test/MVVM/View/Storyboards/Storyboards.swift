//
//  Storyboards.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiate(from storyboard:Storyboards, identifier: String? = nil) -> Self {
        return instantiateFromStoryboard(storyboard.rawValue, identifier)
    }
}

enum Storyboards: String {
    case postsFeed = "PostsFeed"
    
    func instantiateInitialVC() -> UIViewController? {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController()
    }
    
    func instantiateInitialNC() -> UINavigationController? {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController() as? UINavigationController
    }
    
    func instantiate(identifier: String) -> UIViewController {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func instantiate<T:UIViewController> (identifier: String, type: T.Type) -> T {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier) as! T
    }
}
