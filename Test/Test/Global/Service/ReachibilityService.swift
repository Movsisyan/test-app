//
//  ReachibilityService.swift
//  Test
//
//  Created by Mher Movsisyan on 10/10/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import Reachability
import RxCocoa

class ReachibilityService {
    
    var isReachable: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    
    static let shared = ReachibilityService()
    
    private var reachability : Reachability!
    private var isReachablitySet = false

    private init() {}
    
    func observeReachability(){
        self.reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular,
             .wifi:
            isReachable.accept(true)
        case .none:
            isReachable.accept(false)
        }
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self)
    }
}
