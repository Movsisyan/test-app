//
//  PostsFeedViewModeling.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation

protocol PostsFeedViewModeling: BaseViewModelling {
    func getData()
    func numberOfRows() -> Int
    func cellViewModel(at: IndexPath) -> PostCellViewModel
}
