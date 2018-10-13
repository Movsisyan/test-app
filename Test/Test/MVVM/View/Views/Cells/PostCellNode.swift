//
//  PostCellNode.swift
//  Test
//
//  Created by Mher Movsisyan on 10/11/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import AsyncDisplayKit
import Kingfisher

class PostCellNode: ASCellNode {
    
    var postLabel = ASTextNode()
    var postImageView = ASNetworkImageNode()
    var name: String!
    
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
        postImageView.placeholderFadeDuration = 0.15
        postImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubnode(postLabel)
        self.addSubnode(postImageView)
    }
    
    func createLayerBackedTextNode(attributedString: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.isLayerBacked = true
        textNode.attributedText = attributedString
        
        return textNode
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 16, 0, 16), child: postLabel)
        
        let ratio: CGFloat = 2.0/3.0
        let imageRationSpec = ASRatioLayoutSpec(ratio: ratio, child: postImageView)
        
        let verticalStack = ASStackLayoutSpec.vertical()
        if viewModel.coverURL != nil {
            verticalStack.children = [nameInsetSpec, imageRationSpec]
        } else {
            verticalStack.children = [nameInsetSpec]
        }
        return verticalStack
    }
}

extension PostCellNode: ASNetworkImageNodeDelegate {
    func imageNode(_ imageNode: ASNetworkImageNode, didFailWithError error: Error) {
        // TODO: -
    }
    
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        // TODO: -
    }
}
