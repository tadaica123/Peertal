//
//  ViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/7/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var leftTabContraint: NSLayoutConstraint!
    @IBOutlet weak var underLineView : UIView!
    var tabBar: UITabBarController!
    var navNewFeed: UINavigationController!
    var navEncounted: UINavigationController!
    var navNearby: UINavigationController!
    var navNetwork: UINavigationController!
    var navAllProfile: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initTabView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTabView(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newFeedController = mainStoryboard.instantiateViewController(withIdentifier: "NewFeedViewController") ;
        let encounterController = mainStoryboard.instantiateViewController(withIdentifier: "EncountersViewController") ;
        let nearbyController = mainStoryboard.instantiateViewController(withIdentifier: "NearbyViewController") ;
        let networkController = mainStoryboard.instantiateViewController(withIdentifier: "NetworkViewController") ;
        let allProfileController = mainStoryboard.instantiateViewController(withIdentifier: "AllProfileViewController") ;
        navNewFeed = UINavigationController.init(rootViewController: newFeedController);
        navNewFeed.isNavigationBarHidden = true;
        navNewFeed.isToolbarHidden = true;
        navEncounted = UINavigationController.init(rootViewController: encounterController);
        navEncounted.isNavigationBarHidden = true;
        navEncounted.isToolbarHidden = true;
        navNearby = UINavigationController.init(rootViewController: nearbyController);
        navNearby.isNavigationBarHidden = true;
        navNearby.isToolbarHidden = true;
        navNetwork = UINavigationController.init(rootViewController: networkController);
        navNetwork.isNavigationBarHidden = true;
        navNetwork.isToolbarHidden = true;
        navAllProfile = UINavigationController.init(rootViewController: allProfileController);
        navAllProfile.isNavigationBarHidden = true;
        navAllProfile.isToolbarHidden = true;
        
        tabBar = UITabBarController.init();
        tabBar.viewControllers = [navNewFeed, navEncounted, navNearby, navNetwork, navAllProfile];
        tabBar.tabBar.isHidden = true;
        self.view.addSubview(tabBar.view);
        
        let leadingContrains = NSLayoutConstraint(item: tabBar.view, attribute:.leadingMargin, relatedBy:.equal, toItem: self.view, attribute:.leadingMargin, multiplier: 1, constant: 0);
        let trailingContrains = NSLayoutConstraint(item: tabBar.view, attribute:.trailingMargin, relatedBy:.equal, toItem: self.view, attribute:.trailingMargin, multiplier: 1, constant: 0);
        let topContrains = NSLayoutConstraint(item: tabBar.view, attribute:.top, relatedBy:.equal, toItem: underLineView, attribute:.top, multiplier: 1, constant: 4);
        let bottomContrains = NSLayoutConstraint(item: tabBar.view, attribute:.bottom, relatedBy:.equal, toItem: self.view, attribute:.bottom, multiplier: 1, constant: 0);
        
        tabBar.view.translatesAutoresizingMaskIntoConstraints = false;

        NSLayoutConstraint.activate([leadingContrains, trailingContrains,topContrains, bottomContrains]);
        tabBar.selectedIndex = 0;
    }

    
    @IBAction func buttonMenuPressed(_ sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    @IBAction func buttonSearchPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueIdentifier", sender: self)    }


    @IBAction func buttonTabPressed(_ sender: UIButton) {
        tabBar.selectedIndex = sender.tag;
        leftTabContraint.constant = CGFloat(sender.tag) * sender.frame.size.width;
    }

}
