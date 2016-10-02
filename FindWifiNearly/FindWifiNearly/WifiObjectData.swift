//
//  WifiObjectData.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 5/4/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

class WifiObjectData: NSObject {
    
    override init(){
        super.init();
        // other code
    }
    
    func getListSSID() -> Array<NSDictionary> {
        var listSSID:Array<NSDictionary> = Array<NSDictionary>();
        var macAdrees:String = ""
        var currentSSID:String = ""
        
        let interfaces:CFArray! = CNCopySupportedInterfaces()
        for i in 0..<CFArrayGetCount(interfaces){
            let interfaceName: UnsafeRawPointer
                =  CFArrayGetValueAtIndex(interfaces, i)
            let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
            let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
            if unsafeInterfaceData != nil {
                let interfaceData = unsafeInterfaceData! as Dictionary!
                currentSSID = (interfaceData as AnyObject)["SSID"] as! String
                macAdrees = (interfaceData as AnyObject)["BSSID"] as! String
//                succes = true
            } else {
//               currentSSID = ""
            }
            let data:NSDictionary = ["name":currentSSID, "id":macAdrees]
            listSSID.append(data)
        }
        
//        for(let hotspotNetwork in [NEHotspotHelper supportedNetworkInterfaces]) {
//            NSString *ssid = hotspotNetwork.SSID;
//            NSString *bssid = hotspotNetwork.BSSID;
//            BOOL secure = hotspotNetwork.secure;
//            BOOL autoJoined = hotspotNetwork.autoJoined;
//            double signalStrength = hotspotNetwork.signalStrength;
//        }
        return listSSID
    }
    
    func getFetchSSID() -> String{
        
        
        var macAdrees:String = ""
        
        let interfaces:CFArray! = CNCopySupportedInterfaces()
        for i in 0..<CFArrayGetCount(interfaces){
            let interfaceName: UnsafeRawPointer
                =  CFArrayGetValueAtIndex(interfaces, i)
            let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
            let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
            if unsafeInterfaceData != nil {
                let interfaceData = unsafeInterfaceData! as Dictionary!
                macAdrees = (interfaceData as AnyObject)["BSSID"] as! String
                //                succes = true
            } else {
                //               currentSSID = ""
            }
        }
        return macAdrees
    }

    
}


