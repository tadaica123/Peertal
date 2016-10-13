//
//  DialogManager.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 5/14/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import Foundation

class DialogManager: NSObject {
    
    let alert: UIAlertView = UIAlertView(title: nil, message: "Please wait...", delegate: nil, cancelButtonTitle: "Dismiss");
    
    func showDialogLoading (){
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:50, y:10,width: 37, height: 37)) as UIActivityIndicatorView
        loadingIndicator.center = alert.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        alert.show();
    }
    
    func dismissDialogloading(){
        alert.dismiss(withClickedButtonIndex: 0, animated: true);
    }
    
    func showDialogError(view: UIViewController, error: String){
        let alertController = UIAlertController(title: "Error", message:
            error, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Oke", style: UIAlertActionStyle.default,handler: nil))
        
        view.present(alertController, animated: true, completion: nil)
    }

}
