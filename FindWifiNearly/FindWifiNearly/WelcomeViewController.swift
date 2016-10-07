//
//  WelcomeViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/2/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class WelcomeViewController:  UIViewController , BackendAPIManagerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueIdentifier", sender: self)

    }
    
    func requestCompelte(_ response: String) {

        
    }
    
    func requestFailed(_ response:String){
       
    }
}
