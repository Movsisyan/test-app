//
//  BaseViewModel.swift
//  Test
//
//  Created by Mher Movsisyan on 10/8/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BaseViewModel: BaseViewModelling {
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var error: BehaviorRelay<Error?> = BehaviorRelay(value: nil)
    var isSuccess: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var disposeBag = DisposeBag()
}
