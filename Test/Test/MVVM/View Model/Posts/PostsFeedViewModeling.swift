//
//  PostsFeedViewModeling.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import RxCocoa

protocol PostsFeedViewModeling: BaseViewModelling {
    var shouldLoadMoreData: Bool {get}
    var showNetworkReachibilityAlert: BehaviorRelay<String?> {get}
    
    func loadData()
    func numberOfRows() -> Int
    func cellViewModel(at: IndexPath) -> PostCellViewModel
}
