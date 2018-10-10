//
//  ReachibilityService.swift
//  Test
//
//  Created by Mher Movsisyan on 10/10/18.
//  Copyright © 2018 Mher Movsisyan. All rights reserved.
//

import Foundation
import Reachability

class ReachibilityService {
    
    var isReachable = true
    static let shared = ReachibilityService()
    
    private var reachability : Reachability!
    
    private init() {}
    
    func observeReachability(){
        self.reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        reachability.startNotifier()
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        self.isReachable = reachability.isReachable()
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self)
    }
}
