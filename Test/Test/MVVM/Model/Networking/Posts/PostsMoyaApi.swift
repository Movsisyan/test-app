//
//  PostsMoyaApi.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import Moya

enum PostsMoyaApi: TargetType {
    case getPosts(page: Int)
    
    var baseURL: URL {
        return URL(string: Config.apiBaseURL)!
    }
    
    var path: String {
        switch self {
        case .getPosts:
             return "/wall.get"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPosts(page: let page):
            var params = [String: Any]()
            params["owner_id"] = Config.allMeCommunityID
            params["count"] = Config.offset
            params["offset"] = page * Config.offset
            params.merge(defaultParameters) {$1}
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}


