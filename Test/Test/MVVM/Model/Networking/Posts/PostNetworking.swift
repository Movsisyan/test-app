//
//  PostNetworking.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import RxSwift

protocol PostNetworking {
    func getPosts(page: Int) -> Observable<NetworkResponse<Post>?>
}
