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
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: PostCellViewModel! {
        didSet {
            postLabel.text = viewModel.text
            
            if let url = viewModel.coverURL {
                imageViewTopConstraint.constant = 20
                imageViewHeightConstraint.constant = UIScreen.main.bounds.width - 40
                
                postImageView.kf.indicatorType = .activity
                postImageView.kf.cancelDownloadTask()
                postImageView.kf.setImage(with: url) {[weak self] (image, _, _, _) in
                    guard let image = image else {return}
                    let ratio = image.size.height / image.size.width
                    self?.imageViewHeightConstraint.constant = (UIScreen.main.bounds.width - 40) * ratio
                }
            } else {
                imageViewTopConstraint.constant = 0
                imageViewHeightConstraint.constant = 0
            }
        }
    }
}
