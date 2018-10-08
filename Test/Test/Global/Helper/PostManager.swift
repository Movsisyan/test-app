//
//  PostManager.swift
//  Test
//
//  Created by Mher Movsisyan on 10/8/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation

struct PostManager {
    static func defaultFormat(_ text: String) -> String {
        if text.count <= 50 {
            return text
        } else {
            return String(text.prefix(50)) + "..."
        }
    }
}
