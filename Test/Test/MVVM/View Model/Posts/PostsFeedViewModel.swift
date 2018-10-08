//
//  PostsFeedViewModel.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import RxSwift

class PostsFeedViewModel: PostsFeedViewModeling {
    
    let disposeBag = DisposeBag()
    let network: PostNetworking = PostsMoyaNetwork()
    
    func getData() {
        network.getPosts(page: 1).subscribe { event in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error.localizedDescription)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}
