//
//  Moya+Global.swift
//  Test
//
//  Created by Mher Movsisyan on 10/7/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

extension TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var defaultParameters: [String: Any] {
        return ["access_token": Config.serviceToken, "v": Config.apiVersion]
    }
}

extension MoyaProvider {
    convenience init(useGlobalSettings: Bool, useSampleData: Bool) {
        let stubClosure: StubClosure = useSampleData ? MoyaProvider.delayedStub(2) : MoyaProvider.neverStub
        
        self.init(endpointClosure: { (target: Target) -> Endpoint in
            var endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            if !useGlobalSettings {
                return endpoint
            }
            endpoint = endpoint.adding(newHTTPHeaderFields: ["os": "iOS"])
            
            return endpoint
        }, stubClosure: stubClosure, plugins: [NetworkLoggerPlugin(verbose: true)])
    }
}
