//
//  AppDelegate.swift
//  Test
//
//  Created by Mher Movsisyan on 10/6/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ReachibilityService.shared.observeReachability()
        SVProgressHUD.setDefaultMaskType(.black)
        
        return true
    }
}

