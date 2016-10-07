//
//  SignInViewController2.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/7/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class SignInViewController2:  UIViewController , BackendAPIManagerDelegate{
    
    @IBAction func buttonEnterPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueIdentifier", sender: self)
        
    }
    
    @IBAction func buttonCancelPressed(_ sender: AnyObject) {
       _ = navigationController?.popViewController(animated: true)
        
    }
    
    func requestCompelte(_ response: String) {
        
        
    }
    
    func requestFailed(_ response:String){
        
    }
}
