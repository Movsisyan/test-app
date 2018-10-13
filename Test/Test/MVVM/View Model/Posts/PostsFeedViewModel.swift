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
    
    var shouldLoadMoreData: Bool {
        let resultCount = result?.count ?? 0
        if resultCount - upperBound < Config.offset && !isReachable {
            return false
        }
        
        if let totalCount = totalCount {
            return totalCount != postViewModels.count
        }
        
        return true
    }
    var showNetworkReachibilityAlert: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    private var upperBound: Int {
        let resultCount = result?.count ?? 0
        return postViewModels.count + Config.offset >= resultCount ? resultCount : postViewModels.count + Config.offset
    }
    private var postViewModels = [PostCellViewModel]()
    private var isReachable = true
    private var isFetchingData = false
    private var totalCount: Int? = nil
    private var result: Results<Post>? {
        return PostsDBManager.shared.getPosts()
    }
    
    override init() {
        super.init()
        
        ReachibilityService.shared.isReachable.filter{$0 != nil}.map{$0!}.subscribe(onNext: { [weak self] (isReachable) in
            guard let wSelf = self else {return}
            wSelf.isReachable = isReachable
            if isReachable {
                wSelf.showNetworkReachibilityAlert.accept(Constants.AlertMessages.reachable)
                wSelf.loadData()
            } else {
                wSelf.showNetworkReachibilityAlert.accept(Constants.AlertMessages.unreachable)
            }
        }).disposed(by: disposeBag)
    }
    
    func loadData() {
        loadDataFromRealm()
    }
    
    func loadDataFromNetwork() {
        guard let result = result else {return}
        if result.isEmpty {
            isLoading.accept(true)
        }
        if let totalCount = totalCount {
            if result.count == totalCount {
                return
            }
        }
        let page = result.count/Config.offset + 1
        if isFetchingData {return}
        isFetchingData = true
        network.getPosts(page: page).subscribe {[weak self] event in
            guard let wSelf = self else {return}
            wSelf.isLoading.accept(false)
            wSelf.isFetchingData = false
            switch event {
            case .next(let data):
                guard let data = data else {return}
                PostsDBManager.shared.addPosts(data.list)
                wSelf.totalCount = data.totalCount
            case .error(let error):
                if !wSelf.isReachable {return}
                wSelf.error.accept(error)
            default:
                break
            }
            }.disposed(by: disposeBag)
    }
    
    func loadDataFromRealm() {
        loadDataFromNetwork()
        guard let result = result else {return}

        for i in postViewModels.count..<upperBound {
            postViewModels.append(PostCellViewModel(result[i]))
        }
        self.isSuccess.accept(true)
    }
    
    func numberOfRows() -> Int {
        return postViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> PostCellViewModel {
        return postViewModels[indexPath.row]
    }
}
