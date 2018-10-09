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
    var page: Int = 0
    var isFetchingData = false
    var noMoreAvailableData = false
    
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
                self?.noMoreAvailableData = data.isEmpty
                self?.posts += data
                self?.isSuccess.accept(true)
            case .error(let error):
                print(error.localizedDescription)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
    
    func loadMoreData(indexPath: IndexPath?) {
        guard let indexPath = indexPath else {return}
        if indexPath.row == numberOfRows() - 1 && !isFetchingData && !noMoreAvailableData {
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
