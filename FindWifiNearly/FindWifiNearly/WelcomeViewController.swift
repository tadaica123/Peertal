//
//  WelcomeViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/2/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class WelcomeViewController:  UIViewController , UITextFieldDelegate, BackendAPIManagerDelegate{
    
    @IBOutlet weak var viewTypeName: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var user_name : String! = nil
    var email : String! = nil
    
    let apiObject:BackendAPIManager! = BackendAPIManager()
    let dialogMananger:DialogManager! = DialogManager()
    let utils:UtilsManager! = UtilsManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiObject.setDelegate(self);
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
//        self.performSegue(withIdentifier: "segueIdentifier", sender: self)
      
        signUp(userName: user_name);
    }
    
    @IBAction func loadingDialogPress(_ sender: AnyObject) {
        viewTypeName.isHidden = true
    }
    
    func requestCompelte(_ response: String) {
        let dataTemp = response.data(using: String.Encoding.utf8)
        let dic = try! JSONSerialization.jsonObject(with: dataTemp!, options: [])
        let status = (dic as AnyObject)["status"] as! Int
        let msg = (dic as AnyObject)["message"] as! String
        let data = (dic as AnyObject)["data"]
        let userData = (data as AnyObject)["user_data"]
        let userId = (userData as AnyObject)["user_id"] as! Int
        let accessToken = (userData as AnyObject)["access_token"] as! String
        if  status == 1 { // Success
            switch apiObject.lastAction {
            case apiObject.REQUEST_ACTION_LOGIN:
                let dicStorage = ["user_id": userId, "access_token": accessToken] as [String : Any]
                utils.cacheUser(dicStorage as NSDictionary)
                break
            default:
                break
            }
            // Go To Next Page
            dialogMananger.dismissDialogloading();
            if !response.isEqual(""){
                self.performSegue(withIdentifier: "segueIdentifier", sender: self);
            }
        } else  { // error
            dialogMananger.dismissDialogloading();
            let alertController = UIAlertController(title: "Error", message:
                msg, preferredStyle: UIAlertControllerStyle.alert);
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil));
            
            self.present(alertController, animated: true, completion: nil);
            return
            
        }
        
    }
    
    func requestFailed(_ response:String){
       dialogMananger.showDialogError(view: self, error: response)
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func signUp(userName: String){
        dialogMananger.showDialogLoading();
        email = txtEmail.text;
        if (email!.isEqual("")){
            dialogMananger.showDialogError(view: self, error: "Please input email" );
            return
        }
        
        apiObject.lastAction = apiObject.REQUEST_ACTION_LOGIN
        let paramsLevel3:NSMutableDictionary = ["email":email!, "user_name":userName]
        let paramsLevel2:NSMutableDictionary = ["access_token": (apiObject.md5AccessToken(email!)),"action":apiObject.REQUEST_ACTION_LOGIN, "data":paramsLevel3]
        
        let json = try! JSONSerialization.data(withJSONObject: paramsLevel2,  options: JSONSerialization.WritingOptions.init(rawValue: 2))
        let datastring = String(data: json, encoding: String.Encoding.utf8)
        
        var requestDataString : Dictionary<String, String> = [:]
        requestDataString["json_data"] = datastring
        //        let paramsLevel1:NSMutableDictionary = ["json_data":paramsLevel2]
        
        print("json = \(datastring)")
        apiObject.requestData(requestDataString)
        
    }
}
