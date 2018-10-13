//
//  PostCellViewModel.swift
//  Test
//
//  Created by Mher Movsisyan on 10/8/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation

struct PostCellViewModel {
    let text: String
    let coverURL: URL?
    
    init(_ post: Post) {
        self.text = PostManager.defaultFormat(post.text)
        if let path = post.imagePath {
            coverURL = URL(string: path)
        } else {
            coverURL = nil
        }
    }
}
