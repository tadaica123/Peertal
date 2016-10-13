//
//  LeftSlideViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/7/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class LeftSlideViewController: UIViewController {
    
    let pageManager:PageManager! = PageManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonHOMEPressed(_ sender: AnyObject) {
        pageManager.showToViewInSlideMenu(nowView: self, identiferId: "HomePageViewController");
    }
    
    @IBAction func buttonACQUISTIONPressed(_ sender: AnyObject) {
        pageManager.showToViewInSlideMenu(nowView: self, identiferId: "AcquistionViewController");
    }
    
    @IBAction func buttonPROFILEPressed(_ sender: AnyObject) {
        pageManager.showToViewInSlideMenu(nowView: self, identiferId: "UserDetailViewController");

    }

    @IBAction func buttonSETTINGPressed(_ sender: AnyObject) {
        pageManager.showToViewInSlideMenu(nowView: self, identiferId: "SettingViewController");

    }
    
    @IBAction func buttonLOGOUTPressed(_ sender: AnyObject) {
        pageManager.showToViewInSlideMenu(nowView: self, identiferId: "WelcomeViewController");
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
