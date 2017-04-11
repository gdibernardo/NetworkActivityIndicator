//
//  NetworkActivityIndicator.swift
//  NetworkActivityIndicator
//
//  Created by Gabriele Di Bernardo on 11/04/2017.
//  Copyright © 2017 Gabriele Di Bernardo. All rights reserved.
//


import Foundation
import UIKit



public class NetworkActivityIndicator: NSObject
{
    private static let instance = NetworkActivityIndicator()
    
    private var requestedActivities: Int = 0
    
    
    
    public static func sharedInstance() -> NetworkActivityIndicator
    {
        return instance
    }
    
    
    public func show()
    {
        self.lock()
        
        defer {
            self.unlock()
        }
        
        self.requestedActivities += 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    
    public func hide()
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
    
    
    public func isOnScreen() -> Bool
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
