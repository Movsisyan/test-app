//
//  BaseVC.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        errorHandling()
    }

    func setupBindings(){}
    func errorHandling(){}
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
