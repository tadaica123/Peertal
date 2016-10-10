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
        self.layer.borderColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).cgColor
        


    }
}
