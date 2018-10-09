//
//  Post.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import ObjectMapper

struct Post: Mappable {
    var id: Int!
    var text: String = ""
    var imagePath: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id   <- map["id"]
        text <- map["text"]
        
        guard let attachments = map.JSON["attachments"] as? [[String: Any]],
            let photos = attachments.first,
            let photo = photos["photo"] as? [String: Any],
            let sizes = photo["sizes"] as? [[String: Any]],
            let imageData = sizes.first,
            let path = imageData["url"] as? String else {return}
        imagePath = path
    }
}

