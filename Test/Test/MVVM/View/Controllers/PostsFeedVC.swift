//
//  PostsFeedVC.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class PostsFeedVC: BaseVC {

    let viewModel: PostsFeedViewModeling = PostsFeedViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getData()
        tableView.register(PostCell.self)
    }
    
    override func setupBindings() {
        viewModel.isLoading.asDriver().drive(onNext: { (isLoading) in
            isLoading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }).disposed(by: disposeBag)
        
        viewModel.isSuccess.asDriver().filter{$0}.drive(onNext: {[weak self] (_) in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension PostsFeedVC: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
}