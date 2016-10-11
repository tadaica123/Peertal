//
//  ViewController.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/10/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import AVFoundation

class UserDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableViewWhatIQ: UITableView!
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var mainViewContraintHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewWhatIQContraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewCommentContraint: NSLayoutConstraint!
    var menuItems:[String] = ["Ta", "Test","Ta", "Test","Ta", "Test","Ta", "Test"];
    var menuItems2:[String] = ["Ta", "Test","Ta", "Test"];
    var yOfTableViewComment: CGFloat = 784 + 70 + 10 // + header height + bottom space
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonMenuPressed(_ sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil);
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 3){
            let calculatedTableIQHeight = CGFloat(self.menuItems.count) * tableView.rowHeight;
            tableViewWhatIQContraint.constant = calculatedTableIQHeight;
            return menuItems.count;
        } else {
            let calculatedTableIQHeight = CGFloat(self.menuItems.count) * tableView.rowHeight;
            let calculatedTableHeight = CGFloat(self.menuItems2.count) * tableView.rowHeight;
            tableViewCommentContraint.constant = calculatedTableHeight;
            let temp = calculatedTableHeight +  calculatedTableIQHeight + yOfTableViewComment;
            mainViewContraintHeight.constant = temp
            return menuItems2.count;
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView.tag == 3){
            let mycell = tableView.dequeueReusableCell(withIdentifier: "WhatIQCell", for: indexPath) as! WhatIQAndHowRatingTableViewCell;
            mycell.lblText.text = menuItems[indexPath.row];
            return mycell;
        } else {
            let mycell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell;
            mycell.lblText.text = menuItems2[indexPath.row];
            return mycell;
        }
      
        
    }

    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: UIControlState());
        radioButton.setTitleColor(color, for: UIControlState());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(UserDetailViewController.logSelectedButton), for: UIControlEvents.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc @IBAction fileprivate func logSelectedButton(_ radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
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
