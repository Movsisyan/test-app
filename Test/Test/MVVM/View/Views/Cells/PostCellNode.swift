//
//  PostCellNode.swift
//  Test
//
//  Created by Mher Movsisyan on 10/11/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import AsyncDisplayKit

class PostCellNode: ASCellNode {
    
    var postLabel = ASTextNode()
    var postImageView = ASNetworkImageNode()
    
    var viewModel: PostCellViewModel! {
        didSet {
            let attrs = [NSAttributedStringKey.font: Constants.Font.default, NSAttributedStringKey.strokeColor: UIColor.darkGray]
            let string = NSAttributedString(string: viewModel.text, attributes: attrs)
            
            postLabel.attributedText = string
            postImageView.url = viewModel.coverURL
        }
    }
    
    override init() {
        super.init()
        
        postLabel.isLayerBacked = true
        postLabel.isOpaque = false
        
        postImageView.clipsToBounds = true
        postImageView.delegate = self
        postImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubnode(postLabel)
        self.addSubnode(postImageView)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 16, 0, 16), child: postLabel)
        
        let width = UIScreen.main.bounds.size.width
        if let image = postImageView.image {
            let ratio = image.size.height/image.size.width
            postImageView.style.preferredSize = CGSize(width: width, height: width * ratio)
        } else {
            postImageView.style.preferredSize = CGSize(width: width, height: width)
        }
        
        let verticalStack = ASStackLayoutSpec.vertical()
        if viewModel.coverURL != nil {
            verticalStack.children = [nameInsetSpec, postImageView]
        } else {
            verticalStack.children = [nameInsetSpec]
        }
        return verticalStack
    }
}

extension PostCellNode: ASNetworkImageNodeDelegate {
    func imageNode(_ imageNode: ASNetworkImageNode, didFailWithError error: Error) {
        // TODO: - Resize cell to fit failed case
    }
    
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        // TODO: - Find way to resize cell to fit it's image node content size
        // self.invalidateCalculatedLayout()
    }
}
