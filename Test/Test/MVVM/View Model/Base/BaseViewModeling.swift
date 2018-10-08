//
//  BaseViewModeling.swift
//  Test
//
//  Created by Mher Movsisyan on 10/8/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import RxCocoa

protocol BaseViewModelling {
    var isLoading: BehaviorRelay<Bool> {get}
    var error: BehaviorRelay<Error?> {get}
    var isSuccess: BehaviorRelay<Bool> {get set}
}
