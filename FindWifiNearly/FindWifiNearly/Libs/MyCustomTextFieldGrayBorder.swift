//
//  MyCustomTextFieldGrayBorder.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 10/10/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class MyCustomTextFieldGrayBorder: UITextField {

    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1).cgColor
        
    }
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
