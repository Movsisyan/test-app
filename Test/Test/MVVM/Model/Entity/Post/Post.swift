//
//  Post.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import ObjectMapper
import RealmSwift

final class Post: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var imagePath: String?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Post: Mappable {
    func mapping(map: Map) {
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

