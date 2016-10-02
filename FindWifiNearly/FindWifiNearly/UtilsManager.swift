//
//  UtilsManager.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 5/11/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import Foundation

class UtilsManager: NSObject {
    
    
    func cacheUser(_ dic:NSDictionary) {
        let user: UserDefaults = UserDefaults.standard
        user.set(dic, forKey: "user_data")
    }
    
    func getUserCache(_ key:String) -> NSDictionary{
        let user: UserDefaults = UserDefaults.standard
        return user.object(forKey: key) as! NSDictionary
    }

    
}
