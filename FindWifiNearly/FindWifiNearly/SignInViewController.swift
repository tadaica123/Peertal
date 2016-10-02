//
//  ViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 5/4/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class SignInViewController:  UIViewController,  UITextFieldDelegate , BackendAPIManagerDelegate{
    
    @IBOutlet var textFieldUserName: UITextField!
    @IBOutlet var textFieldPW: UITextField!
    @IBOutlet var loadingView: UIView!
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        signIn()
    }
    
    @IBAction func loadingDialogPress(_ sender: AnyObject) {
        loadingView.isHidden = true
    }
    
    let apiObject:BackendAPIManager! = BackendAPIManager()
    let utils:UtilsManager! = UtilsManager()
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiObject.setDelegate(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func signIn(){
        loadingView.isHidden = false
        var email = textFieldUserName.text
        var pw = textFieldPW.text

        email = "user2@gmail.com"
        pw = "123456"
        if email!.isEqual(""){
            let alertController = UIAlertController(title: "Error", message:
                "Please input email!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if pw!.isEqual(""){
            let alertController = UIAlertController(title: "Error", message:
                "Please input password!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        apiObject.lastAction = apiObject.LOGIN_STRING
        let paramsLevel3:NSMutableDictionary = ["email":email!, "password":pw!]
        let paramsLevel2:NSMutableDictionary = ["access_token": (apiObject.md5AccessToken(email!)),"action":apiObject.LOGIN_STRING, "data":paramsLevel3]
        
        let json = try! JSONSerialization.data(withJSONObject: paramsLevel2,  options: JSONSerialization.WritingOptions.init(rawValue: 2))
        let datastring = String(data: json, encoding: String.Encoding.utf8)
        
        var requestDataString : Dictionary<String, String> = [:]
        requestDataString["json_data"] = datastring
//        let paramsLevel1:NSMutableDictionary = ["json_data":paramsLevel2]

        print("json = \(datastring)")
        apiObject.requestData(requestDataString)
        
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
            case apiObject.LOGIN_STRING:
                let dicStorage = ["user_id": userId, "access_token": accessToken] as [String : Any]
                utils.cacheUser(dicStorage as NSDictionary)
                break
            default:
                break
            }
            // Go To Next Page
            loadingView.isHidden = true
            if !response.isEqual(""){
                self.performSegue(withIdentifier: "segueIdentifier", sender: self)
            }
        } else  { // error
            loadingView.isHidden = true
            let alertController = UIAlertController(title: "Error", message:
                msg, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            return

        }

    }
    
    func requestFailed(_ response:String){
        loadingView.isHidden = true
        let alertController = UIAlertController(title: "Error", message:
            response, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

       
}

