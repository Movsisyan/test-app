//
//  PostsFeedVC.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import RxSwift
import SVProgressHUD
import AsyncDisplayKit

class PostsFeedVC: BaseVC {

    let viewModel: PostsFeedViewModeling = PostsFeedViewModel()
    let tableNode = ASTableNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableNode()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableNode.frame = view.bounds
    }
    
    private func setupTableNode() {
        view.addSubnode(tableNode)
        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.view.allowsSelection = false
        tableNode.view.separatorStyle = .singleLineEtched
    }
    
    override func setupBindings() {
        viewModel.isLoading.asDriver().drive(onNext: { (isLoading) in
            isLoading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }).disposed(by: disposeBag)
        
        viewModel.isSuccess.asDriver().filter{$0}.drive(onNext: {[weak self] (_) in
            self?.tableNode.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.showNetworkReachibilityAlert.asDriver().filter{$0 != nil}.map{$0!}.drive(onNext: { (message) in
            AlertHelper.showAlert(message)
        }).disposed(by: disposeBag)
    }
    
    override func errorHandling() {
        viewModel.error.asDriver().filter{$0 != nil}.map{$0!}.drive(onNext: { (error) in
            AlertHelper.showAlert(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}

// MARK: - ASTableDataSource
extension PostsFeedVC: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let nodeViewModel = viewModel.cellViewModel(at: indexPath)
        
        return {
            let node = PostCellNode()
            node.viewModel = nodeViewModel
            return node
        }
    }
}

// MARK: - ASTableDelegate
extension PostsFeedVC: ASTableDelegate {
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return viewModel.shouldLoadMoreData
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        viewModel.loadData()
        viewModel.isSuccess.subscribe(onNext: { (_) in
            context.completeBatchFetching(true)
        }).disposed(by: disposeBag)
    }
}
