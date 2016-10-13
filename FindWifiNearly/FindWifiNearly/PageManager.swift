//
//  PageManager.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/12/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class PageManager: NSObject {
    

    
    func showToViewInSlideMenu(nowView:UIViewController,identiferId:String) {
        let nextViewController = nowView.storyboard?.instantiateViewController(withIdentifier: identiferId)
        
        let nextNavController = UINavigationController(rootViewController: nextViewController!)
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        nextNavController.isNavigationBarHidden = true;
        appDelegate.centerContainer!.centerViewController = nextNavController
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
        
        
    }

}
