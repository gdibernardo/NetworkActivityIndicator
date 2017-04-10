//
//  NetworkActivityIndicator.swift
//  NetworkActivityIndicator
//
//  Created by Gabriele Di Bernardo on 11/04/2017.
//  Copyright © 2017 Gabriele Di Bernardo. All rights reserved.
//


import Foundation
import UIKit



class NetworkActivityIndicator: NSObject
{
    private static let instance = NetworkActivityIndicator()
    
    private var requestedActivities: Int = 0
    
    
    
    static func sharedInstance() -> NetworkActivityIndicator
    {
        return instance
    }
    
    
    func show()
    {
        self.lock()
        
        defer {
            self.unlock()
        }
        
        self.requestedActivities += 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    
    func hide()
    {
        self.lock()
        
        defer {
            self.unlock()
        }
        
        if(self.requestedActivities > 0)
        {
            self.requestedActivities -= 1
            if(self.requestedActivities == 0)
            {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    
    func isOnScreen() -> Bool
    {
        self.lock()
        defer {
            self.unlock()
        }
        
        if(self.requestedActivities > 0)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    private func lock() {
        objc_sync_enter(self)
    }
    
    
    private func unlock() {
        objc_sync_exit(self)
    }
}
