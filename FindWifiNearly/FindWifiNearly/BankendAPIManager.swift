//
//  BankendAPIManager.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 5/10/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import CoreBluetooth
import Foundation

protocol BackendAPIManagerDelegate: NSObjectProtocol {
    func requestFailed(_ err:String)
    func requestCompelte(_ response:String)
}

class BackendAPIManager: NSObject, ASIHTTPRequestDelegate{
    let reuqestHost:String = "http://peertal.oocms.org/api/peertal"
    
    let PRIVATE_KEY = "27fe082f70e4007cdf243a1754b203cd"
    
    let LOGIN_STRING:String = "login_set"
    let WIFI_GET_STRING:String = "wifi_log_set"
    let BLE_GET_STRING:String = "bluetooth_log_set"
    
    var delegate:BackendAPIManagerDelegate!
    var asiRequest:ASIFormDataRequest!
    var lastAction:String = ""
    
    func setDelegate (_ delegate:BackendAPIManagerDelegate){
        self.delegate = delegate
    }
    
    func requestData(_ jsonData:Dictionary<String, String>){
        asiRequest = ASIFormDataRequest.init(url: URL(string: reuqestHost)!)
        asiRequest.delegate = self
        asiRequest.useSessionPersistence = true
        asiRequest.responseEncoding = String.Encoding.utf8.rawValue
        asiRequest.didFinishSelector = #selector(requestFinished)
        asiRequest.didFailSelector = #selector(requestFailed)
        asiRequest.requestHeaders =  NSMutableDictionary(object: "application/xml; charset=UTF-8;", forKey: "Content-Type" as NSCopying)
        asiRequest.requestMethod = "POST"
        for (key, value) in jsonData {
            asiRequest.setPostValue(value as NSObjectProtocol!, forKey: key)
        }
        
        asiRequest.startAsynchronous()
    }
    
    func requestFinished(_ request: ASIHTTPRequest!) {
        print("\(request.responseString())")
//        let data = request.responseString().dataUsingEncoding(NSUTF8StringEncoding)
//        var dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? Dictionary<String, String>
        if ((self.delegate) != nil ) {
            self.delegate.requestCompelte(request.responseString())
        }
    }
    
    func requestFailed(_ request: ASIHTTPRequest!) {
        print("\(request.responseString())")
        var errFail = request.responseString()
        if errFail == nil {
            errFail = "Can not connect to server. Please check your internet connection!"
        }
        if ((self.delegate) != nil ) {
            self.delegate.requestFailed(errFail!)
        }
    }

    
    func md5AccessToken(_ email: String) -> String {
        let string = PRIVATE_KEY + email
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            CC_MD5((data as NSData).bytes, CC_LONG(data.count), &digest)
        }
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
    
}
