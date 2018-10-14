//
//  NetworkResponse.swift
//  Test
//
//  Created by Mher Movsisyan on 10/13/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import ObjectMapper

struct NetworkResponse<T> where T: Mappable {
    var list: [T] = []
    var totalCount: Int = 0
    
    init?(map: Map) {}
}

extension NetworkResponse: Mappable {
    mutating func mapping(map: Map) {
        list <- map["items"]
        totalCount <- map["count"]
    }
}
