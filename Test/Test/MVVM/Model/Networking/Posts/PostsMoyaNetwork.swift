//
//  PostsMoyaNetwork.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

class PostsMoyaNetwork: PostNetworking {
    let provider = MoyaProvider<PostsMoyaApi>(useGlobalSettings: true, useSampleData: false).rx
    
    func getPosts(page: Int) -> Observable<[Post]> {
        return provider.request(.getPosts(page: page)).asObservable().map({
            let response = try? $0.mapJSON()
            guard let json = response as? [String: Any],
                let dictionary = json["response"] as? [String: Any],
                let items = dictionary["items"] as? [[String: Any]] else {return []}
            return Mapper<Post>().mapArray(JSONArray: items)
        })
    }
}
