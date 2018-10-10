//
//  PostsFeedViewModel.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Reachability

class PostsFeedViewModel: BaseViewModel, PostsFeedViewModeling {
    
    let network: PostNetworking = PostsMoyaNetwork()
    
    private var posts = [Post]()
    private var page: Int = 0
    private var isFetchingData = false
    
    func loadData() {
        if page == 0 {
            self.isLoading.accept(true)
        }
        isFetchingData = true
        network.getPosts(page: page).subscribe {[weak self] event in
            self?.isLoading.accept(false)
            self?.isFetchingData = false
            switch event {
            case .next(let data):
                if data.count != Config.offset {
                    self?.page -= 1
                }
                self?.posts += data
                self?.isSuccess.accept(true)
            case .error(let error):
                self?.page -= 1
                self?.error.accept(error)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
    
    func loadMoreData(indexPath: IndexPath?) {
        guard let indexPath = indexPath else {return}
        if indexPath.row == numberOfRows() - 1 && !isFetchingData {
            page += 1
            loadData()
        }
    }
    
    func numberOfRows() -> Int {
        return posts.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> PostCellViewModel {
        return PostCellViewModel(posts[indexPath.row])
    }
}
