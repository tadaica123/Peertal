//
//  LeftSlideViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/7/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class LeftSlideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonHOMEPressed(_ sender: AnyObject) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        
        let nextNavController = UINavigationController(rootViewController: nextViewController)
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        nextNavController.isNavigationBarHidden = true;
        appDelegate.centerContainer!.centerViewController = nextNavController
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    @IBAction func buttonACQUISTIONPressed(_ sender: AnyObject) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "AcquistionViewController") as! AcquistionViewController
        
        let nextNavController = UINavigationController(rootViewController: nextViewController)
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        nextNavController.isNavigationBarHidden = true;
        appDelegate.centerContainer!.centerViewController = nextNavController
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    @IBAction func buttonPROFILEPressed(_ sender: AnyObject) {
        
    }

    @IBAction func buttonSETTINGPressed(_ sender: AnyObject) {
        
    }
    
    @IBAction func buttonLOGOUTPressed(_ sender: AnyObject) {
        
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
