//
//  MainViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 5/4/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import SystemConfiguration
import NetworkExtension

class MainViewController: UIViewController,  UITextFieldDelegate , UITableViewDelegate, UITableViewDataSource, BLEBandManagerDelegate, BackendAPIManagerDelegate {
    
    var typeScan:Int!
    let wifiObject:WifiObjectData! = WifiObjectData()
    let bleObject:BLEManager! = BLEManager()
    let apiObject:BackendAPIManager! = BackendAPIManager()
    let utils:UtilsManager! = UtilsManager()

    @IBOutlet var txtUDID:UILabel!

    @IBOutlet var btnWifi:UIButton!
    @IBOutlet var btnBLE:UIButton!
    @IBOutlet var process1:UIActivityIndicatorView!
    @IBOutlet var process2:UIActivityIndicatorView!

    @IBOutlet var deviceTable:UITableView!
    @IBOutlet var resultTable:UITableView!
    
    var listDeivce:Array<NSDictionary> = Array<NSDictionary>()
    var listResult:Array<NSDictionary> = Array<NSDictionary>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        typeScan = 1
        process1.isHidden = true
        process2.isHidden = true
        btnWifi.isSelected = true
        btnBLE.isSelected = false
        bleObject.setDelegateBand(self)
        apiObject.setDelegate(self)
       txtUDID.text = UIDevice.current.identifierForVendor!.uuidString
        if isConnectedToNetwork(){
            listDeivce = wifiObject.getListSSID()
        } else {
            let alertController = UIAlertController(title: "Error", message:
                "No Internet Connected!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func doScanWifi(){
        apiObject.lastAction = apiObject.WIFI_GET_STRING
        let wifi_id = UIDevice.current.identifierForVendor!.uuidString
        let dic = utils.getUserCache("user_data")
        let accessToken = dic.object(forKey: "access_token") as! String
        let userId = dic.object(forKey: "user_id") as! Int
        let paramsLevel3:NSMutableDictionary = ["wifi_id":wifi_id, "data_login":"","user_id":userId, "hostpot_list":listDeivce]
        let paramsLevel2:NSMutableDictionary = ["access_token": accessToken,"action":apiObject.WIFI_GET_STRING, "data":paramsLevel3]
        
        let json = try! JSONSerialization.data(withJSONObject: paramsLevel2,  options: JSONSerialization.WritingOptions.init(rawValue: 2))
        let datastring = String(data: json, encoding: String.Encoding.utf8)
        
        var requestDataString : Dictionary<String, String> = [:]
        requestDataString["json_data"] = datastring
        print("json = \(datastring)")
        apiObject.requestData(requestDataString)
    }
    
    func doScanBLE(){
        apiObject.lastAction = apiObject.BLE_GET_STRING
        let ble_id = UIDevice.current.identifierForVendor!.uuidString
        let dic = utils.getUserCache("user_data")
        let accessToken = dic.object(forKey: "access_token") as! String
        let userId = dic.object(forKey: "user_id") as! Int
        let paramsLevel3:NSMutableDictionary = ["bluetooth_id":ble_id, "data_login":"","user_id":userId, "bluetooth_list":listDeivce]
        let paramsLevel2:NSMutableDictionary = ["access_token": accessToken,"action":apiObject.BLE_GET_STRING, "data":paramsLevel3]
        
        let json = try! JSONSerialization.data(withJSONObject: paramsLevel2,  options: JSONSerialization.WritingOptions.init(rawValue: 2))
        let datastring = String(data: json, encoding: String.Encoding.utf8)
        
        var requestDataString : Dictionary<String, String> = [:]
        requestDataString["json_data"] = datastring
        print("json = \(datastring)")
        apiObject.requestData(requestDataString)
    }
    
    
    func requestFailed(_ response:String){
        process2.isHidden = true
    }
    
    func requestCompelte(_ response: String) {
        let dataTemp = response.data(using: String.Encoding.utf8)
        let dic = try! JSONSerialization.jsonObject(with: dataTemp!, options: [])
        let status = (dic as AnyObject)["status"] as! Int
        let msg = (dic as AnyObject)["message"] as! String

        if  status == 1 { // Success
            let data = (dic as AnyObject)["data"]
            listResult = (data as AnyObject)["device_list"] as! Array<NSDictionary>
            self.resultTable.reloadData()
            if (listResult.count == 0){
                let alertController = UIAlertController(title: "Result", message:
                    "No Data Result", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        } else  { // error
            let alertController = UIAlertController(title: "Error", message:
                msg, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
      
            
        }
        process2.isHidden = true
    }

    
    func recievedDeviceList(_ arrayDevice:[BLEManager.BluetoothPeripheral]){
        if typeScan == 2{
            listDeivce.removeAll()
            for i in 0  ..< arrayDevice.count {
                let dic:NSDictionary = ["name":arrayDevice[i].name, "id":arrayDevice[i].UUID]
                listDeivce.append(dic)
            }
            process1.isHidden = true
            self.deviceTable.reloadData()
        }
    }
    
    @IBAction func buttonWifiPressed(_ sender: AnyObject) {
        listDeivce.removeAll()
        self.deviceTable.reloadData()
        listResult.removeAll()
        self.resultTable.reloadData()
        typeScan = 1
        btnWifi.isSelected = true
        btnBLE.isSelected = false
        if isConnectedToNetwork(){
            listDeivce = wifiObject.getListSSID()
             self.deviceTable.reloadData()
        } else {
            let alertController = UIAlertController(title: "Error", message:
                "No Internet Connected!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func buttonBLEPressed(_ sender: AnyObject) {
        listDeivce.removeAll()
        self.deviceTable.reloadData()
        listResult.removeAll()
        self.resultTable.reloadData()
        process1.isHidden = false
        let triggerTime = (Int64(NSEC_PER_SEC) * 10)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            self.process1.isHidden = true
        })
        typeScan = 2
        btnWifi.isSelected = false
        btnBLE.isSelected = true
        bleObject.ScanForPeripherals()
    }
    
    @IBAction func buttonScanPressed(_ sender: AnyObject) {
       
        if (typeScan == 2){
            if process1.isHidden{
                 process2.isHidden = false

                doScanBLE()
            } else {
                let alertController = UIAlertController(title: "Warning", message:
                    "Waiting util list BLE load finish", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)

            }
        } else {
             process2.isHidden = false
            doScanWifi()
        }
    }
    
    @IBAction func buttonSignOutPressed(_ sender: AnyObject) {
         navigationController?.popToRootViewController(animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView.tag == 1{
            return listDeivce.count
        } else if tableView.tag == 2 {
            return listResult.count
        }
        return listDeivce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.lineBreakMode = .byWordWrapping;
        cell.textLabel?.numberOfLines = 0;
        if tableView.tag == 1{
            let dic = listDeivce[(indexPath as NSIndexPath).row]
            //        let name = dic.objectForKey("name") as? String
            let id = dic.object(forKey: "id") as? String
            let name = dic.object(forKey: "name") as? String
            cell.textLabel?.text = "Name: " + name! + "/Id: " + id!
        } else if tableView.tag == 2 {
            let dic = listResult[(indexPath as NSIndexPath).row]
            //        let name = dic.objectForKey("name") as? String
            if typeScan == 1{
                let id = dic.object(forKey: "wifi_id") as? String
                let time = dic.object(forKey: "time") as? String
                let username = dic.object(forKey: "username") as? String
                cell.textLabel?.text = username! + "/"  + id! + "/"  + time!
            } else {
                let id = dic.object(forKey: "bluetooth_id") as? String
                let time = dic.object(forKey: "time") as? String
                let username = dic.object(forKey: "username") as? String
                cell.textLabel?.text = username! + "/"  + id! + "/"  + time!
            }
           
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        if tableView.tag == 1{
            return cell.frame.height * 3 / 2;
        } else if tableView.tag == 2 {
           return cell.frame.height * 3 / 2;
        }

        return cell.frame.height;
    }
    
//    override func viewWillAppear(animated: Bool) {
//        
//        
//        if var startedtoDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("ListDeivceItem"){
//            
//            listDeivce.removeAll()
//            startedtoDoItems = NSUserDefaults.standardUserDefaults().objectForKey("ListDeivceItem") as! Array<NSDictionary>
//            for i in 0 ..< startedtoDoItems.count {
//                let stringData:NSDictionary = startedtoDoItems[i]
//                listDeivce.append(stringData)
//            }
//            
//            
//        }
//        
//        deviceTable.reloadData()
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete){
            if tableView.tag == 1{
                listDeivce.remove(at: (indexPath as NSIndexPath).row)
                
                let fixedtoDoItem = listDeivce
                
                UserDefaults.standard.set(fixedtoDoItem, forKey: "ListDeivceItem")
                
                UserDefaults.standard.synchronize()
                
                deviceTable.reloadData()

            } else {
                listResult.remove(at: (indexPath as NSIndexPath).row)
                
                let fixedtoDoItem = listResult
                
                UserDefaults.standard.set(fixedtoDoItem, forKey: "ListDeivceItem")
                
                UserDefaults.standard.synchronize()
                
                resultTable.reloadData()

            }
        }
    }

    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
            
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}
