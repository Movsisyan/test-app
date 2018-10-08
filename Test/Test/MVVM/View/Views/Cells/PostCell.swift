//
//  PostCell.swift
//  Test
//
//  Created by Mher Movsisyan on 10/8/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import UIKit
import Kingfisher

class PostCell: UITableViewCell {

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var viewModel: PostCellViewModel! {
        didSet {
            postLabel.text = viewModel.text
            postImageView.kf.indicatorType = .activity
            postImageView.kf.cancelDownloadTask()
            postImageView.kf.setImage(with: viewModel.coverURL)
        }
    }
}
