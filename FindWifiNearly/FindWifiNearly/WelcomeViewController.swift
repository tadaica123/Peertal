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
    var user_name : String! = "";
    var email : String! = "";
    
    let apiObject:BackendAPIManager! = BackendAPIManager()
    let dialogMananger:DialogManager! = DialogManager()
    let utils:UtilsManager! = UtilsManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiObject.setDelegate(self);
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        signUp(userName: user_name);
    }
    
    @IBAction func buttonAcceptNamePressed(_ sender: AnyObject) {
        user_name =  txtName.text;
        if (user_name == ""){
            dialogMananger.showDialogError(view: self, error: "Please input your name")
            return;
        }
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
        if  status == 1 { // Success
            switch apiObject.lastAction {
            case apiObject.REQUEST_ACTION_LOGIN:
                let dicStorage = ["user_email": email] as [String : Any]
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
        } else if (status == -1){
            viewTypeName.isHidden = false;
        } else  { // error
            dialogMananger.dismissDialogloading();
            dialogMananger.showDialogError(view: self, error: msg);
            return
            
        }
        
    }
    
    func requestFailed(_ response:String){
        dialogMananger.dismissDialogloading();
        dialogMananger.showDialogError(view: self, error: response);
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func signUp(userName: String){
        
        email = txtEmail.text;
        if (email!.isEqual("")){
            dialogMananger.showDialogError(view: self, error: "Please input email");
            return
        }
        
        dialogMananger.showDialogLoading();
        apiObject.lastAction = apiObject.REQUEST_ACTION_LOGIN

        var paramsLevel3:NSMutableDictionary = ["email":email!, "user_name":userName]
        if (user_name == ""){
            paramsLevel3 =  ["email":email!]
        }
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
