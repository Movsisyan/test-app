//
//  PostsFeedViewModel.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import RxSwift

class PostsFeedViewModel: BaseViewModel, PostsFeedViewModeling {
    
    let network: PostNetworking = PostsMoyaNetwork()
    
    var posts = [Post]()
    
    func getData() {
        self.isLoading.accept(true)
        network.getPosts(page: 1).subscribe {[weak self] event in
            self?.isLoading.accept(false)
            switch event {
            case .next(let data):
                self?.posts += data
                self?.isSuccess.accept(true)
            case .error(let error):
                print(error.localizedDescription)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
    
    func numberOfRows() -> Int {
        return posts.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> PostCellViewModel {
        return PostCellViewModel(posts[indexPath.row])
    }
}
