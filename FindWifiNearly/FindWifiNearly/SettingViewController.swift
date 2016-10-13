//
//  SettingViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/12/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var leftTabContraint: NSLayoutConstraint!
    @IBOutlet weak var underLineView : UIView!
    var tabBar: UITabBarController!
    var navAccountSetting: UINavigationController!
    var navNotificationSetting: UINavigationController!
    var navPrivacySetting: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        initTabView();
        
    }
    
    func initTabView(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let accountController = mainStoryboard.instantiateViewController(withIdentifier: "AccoutSettingViewController") ;
        let notificationController = mainStoryboard.instantiateViewController(withIdentifier: "NotificationViewController") ;
        let privacyController = mainStoryboard.instantiateViewController(withIdentifier: "PrivacySettingViewController") ;
        navAccountSetting = UINavigationController.init(rootViewController: accountController);
        navAccountSetting.isNavigationBarHidden = true;
        navAccountSetting.isToolbarHidden = true;
        navNotificationSetting = UINavigationController.init(rootViewController: notificationController);
        navNotificationSetting.isNavigationBarHidden = true;
        navNotificationSetting.isToolbarHidden = true;
        navPrivacySetting = UINavigationController.init(rootViewController: privacyController);
        navPrivacySetting.isNavigationBarHidden = true;
        navPrivacySetting.isToolbarHidden = true;
        
        tabBar = UITabBarController.init();
        tabBar.viewControllers = [navAccountSetting, navNotificationSetting, navPrivacySetting];
        tabBar.tabBar.isHidden = true;
        self.view.addSubview(tabBar.view);
        
        let leadingContrains = NSLayoutConstraint(item: tabBar.view, attribute:.leadingMargin, relatedBy:.equal, toItem: self.view, attribute:.leadingMargin, multiplier: 1, constant: 0);
        let trailingContrains = NSLayoutConstraint(item: tabBar.view, attribute:.trailingMargin, relatedBy:.equal, toItem: self.view, attribute:.trailingMargin, multiplier: 1, constant: 0);
        let topContrains = NSLayoutConstraint(item: tabBar.view, attribute:.top, relatedBy:.equal, toItem: underLineView, attribute:.top, multiplier: 1, constant: 4);
        let bottomContrains = NSLayoutConstraint(item: tabBar.view, attribute:.bottom, relatedBy:.equal, toItem: self.view, attribute:.bottom, multiplier: 1, constant: 0);
        
        tabBar.view.translatesAutoresizingMaskIntoConstraints = false;
        //IOS 8
        //activate the constrains.
        //we pass an array of all the contraints
        NSLayoutConstraint.activate([leadingContrains, trailingContrains,topContrains, bottomContrains]);
        tabBar.selectedIndex = 0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonMenuPressed(_ sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil);
    }

    @IBAction func buttonTabPressed(_ sender: UIButton) {
        tabBar.selectedIndex = sender.tag;
        leftTabContraint.constant = CGFloat(sender.tag) * sender.frame.size.width;
    }

}
