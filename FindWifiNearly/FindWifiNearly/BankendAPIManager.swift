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
    let reuqestHost:String = "https://www.peertal.com";
    let reuqestUserType:String = "/api/mobile";
    
    let PRIVATE_KEY = "b3778f5c414ea8409093e0b9024bca4f";
    
    
    let LOGIN_STRING:String = "login_request";;
    let WIFI_GET_STRING:String = "wifi_log_set"
    let BLE_GET_STRING:String = "bluetooth_log_set";
    
    let REQUEST_ACTION_WIFI_LOG:String = "wifi_log_set";
    let REQUEST_ACTION_BLE_LOG:String = "bluetooth_log_set";
    let REQUEST_ACTION_LOGIN:String = "login_request";
    let REQUEST_ACTION_LOGIN_BY_TOKEN:String = "login_by_token";
    let REQUEST_ACTION_CONTACT_LIST_SET:String = "contact_list_set";
    let REQUEST_ACTION_HOME_ENCOUNTER_GET:String = "home_ecounter_get";
    let REQUEST_ACTION_HOME_ALL_PROFILE_GET:String = "home_all_profile_get";
    let REQUEST_ACTION_HOME_NEARBY_GET:String = "home_nearby_get";
    let REQUEST_ACTION_HOME_NETWORK_GET:String = "home_network_get";
    let REQUEST_ACTION_USER_SETTING_GET:String = "user_setting_set";
    let REQUEST_ACTION_PROFILE_DETAIL_GET:String = "profile_detail_set";
    let REQUEST_ACTION_PROFILE_DETAIL_ADD_SKILL:String = "profile_detail_add_skill";
    let REQUEST_ACTION_PROFILE_DETAIL_ENDORSE_RATING_SUBMIT:String = "profile_detail_endorse_rating_submit";
    let REQUEST_ACTION_PROFILE_DETAIL_ENDORSE_SKILL_SUBMIT:String = "profile_detail_endorse_skill_submit";
    let REQUEST_ACTION_PROFILE_DETAIL_ENDORSE_SUBMIT:String = "profile_detail_endorse_comment_submit";
    let REQUEST_ACTION_PROFILE_DETAIL_ADD_COMMENT:String = "profile_detail_add_comment_submit";
    let REQUEST_ACTION_PROFILE_DETAIL_REPLY_COMMENT:String = "profile_detail_reply_comment_submit";
    let REQUEST_ACTION_PROFILE_DETAIL_EDIT_COMMENT_SUBMIT:String = "profile_detail_edit_comment_submit";
    let REQUEST_ACTION_ACQUISTION_GET:String = "acquistion_get";
    let REQUEST_ACTION_ACQUISTION_UPDATE_IDENTIFIER:String = "acquistion_update_identifier";
    let REQUEST_ACTION_ACQUISTION_ADD_IDENTIFIER:String = "acquistion_add_identifier";
    let REQUEST_ACTION_ACQUISTION_DELETE_IDENTIFIER:String = "acquistion_delete_identifier";
    let REQUEST_ACTION_USER_SETTING_GET_STRING:String = "user_setting_get";
    let REQUEST_ACTION_USER_DATA_GET:String = "user_data_get";
    let REQUEST_ACTION_PROFILE_DETAIL_REPORT_SKILL_SUBMIT:String = "profile_detail_report_skill_submit";
    let REQUEST_ACTION_PROFILE_DETAIL_REPORT_COMMENT_SUBMIT:String = "profile_detail_report_comment_submit";
    let REQUEST_ACTION_HOME_SEARCH_PROFILE_GET:String = "home_search_profile_get";
    let REQUEST_ACTION_HOME_NEW_FEEDS:String = "home_lasted_feed";
    let REQUEST_ACTION_USER_SEND_LOG_SET:String = "user_send_log_set";
    
    
    var delegate:BackendAPIManagerDelegate!;
    var asiRequest:ASIFormDataRequest!;
    var lastAction:String = "";
    
    func setDelegate (_ delegate:BackendAPIManagerDelegate){
        self.delegate = delegate;
    }
    
    func requestData(_ jsonData:Dictionary<String, String>){
        asiRequest = ASIFormDataRequest.init(url: URL(string: reuqestHost + reuqestUserType)!)
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
