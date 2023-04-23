//
//  Reachability.swift
//  UniversalAppDemo
//
//  Created by Harsha on 23/04/2023.
//

import Foundation
import UIKit
import Reachability

class ReachabilityManager {
    
    static let manager = ReachabilityManager()
    
    func isConnected() -> (Bool) {
        let reachability = try! Reachability()
        
        if reachability.connection == .unavailable {
            return false
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        return true
    }
}

