//
//  DialogManager.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 5/14/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import Foundation

class DialogManager: NSObject {
    
    var dialogLoading = UIAlertController(title: nil, message: "Loading", preferredStyle: UIAlertControllerStyle.alert)
    
    
    func initDialogLoading () -> UIAlertController{
        let spinner  = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        spinner.center = dialogLoading.view.center
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        dialogLoading.view.addSubview(spinner)
        spinner.startAnimating()
        return dialogLoading
    }

}
