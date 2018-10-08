//
//  PostsFeedVC.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import UIKit

class PostsFeedVC: BaseVC {

    let viewModel: PostsFeedViewModeling = PostsFeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getData()
    }
}
