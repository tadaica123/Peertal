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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func buttonMenuPressed(_ sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    @IBAction func buttonSearchPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segueIdentifier", sender: self)    }


    @IBAction func buttonTabPressed(_ sender: UIButton) {
//        tabBar.selectedIndex = sender.tag;
        leftTabContraint.constant = CGFloat(sender.tag) * sender.frame.size.width;
    }

}
