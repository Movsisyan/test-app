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
import RealmSwift

class PostsFeedViewModel: BaseViewModel, PostsFeedViewModeling {
    
    let network: PostNetworking = PostsMoyaNetwork()
    
    private var posts = [Post]()
    private var page: Int = 0
    private var isFetchingData = false
    private var isReachable = true
    private var isBottomOfFeed = false
    
    override init() {
        super.init()
        
        ReachibilityService.shared.isReachable.filter{$0 != nil}.map{$0!}.subscribe(onNext: { [weak self] (isReachable) in
            guard let wSelf = self else {return}
            wSelf.isReachable = isReachable
            if !wSelf.isFetchingData {
                wSelf.loadData()
            }
        }).disposed(by: disposeBag)
    }
    
    func loadData() {
        if isBottomOfFeed {return}
        page += 1
        if isReachable {
            loadDataFromNetwork()
        } else {
            loadDataFromRealm()
        }
    }
    
    func loadDataFromNetwork() {
        if page == 1 {
            self.isLoading.accept(true)
        }
        isFetchingData = true
        network.getPosts(page: page).subscribe {[weak self] event in
            guard let wSelf = self else {return}
            wSelf.isLoading.accept(false)
            wSelf.isFetchingData = false
            switch event {
            case .next(let data):
                if data.count != Config.offset {
                    wSelf.page -= 1
                    wSelf.isBottomOfFeed = true
                }
                PostsDBManager.shared.addPosts(data)
                wSelf.posts += data
                wSelf.isSuccess.accept(true)
            case .error(let error):
                wSelf.page -= 1
                wSelf.error.accept(error)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
    
    func loadDataFromRealm() {
        guard let result = PostsDBManager.shared.getUser() else {
            page -= 1
            return}
        let upperBound = posts.count + Config.offset >= result.count ? result.count : posts.count + Config.offset
        if result.count - upperBound < 20 {
            page -= 1
        }
        for i in posts.count..<upperBound {
            posts.append(result[i])
        }
        self.isSuccess.accept(true)
    }
    
    func loadMoreData(indexPath: IndexPath?) {
        guard let indexPath = indexPath else {return}
        if indexPath.row == numberOfRows() - 1 && !isFetchingData {
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
